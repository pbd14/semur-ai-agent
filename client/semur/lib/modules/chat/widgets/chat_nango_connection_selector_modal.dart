import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/nango/nango.pb.dart';
import 'package:semur/semur_engine/nango/nango_engine.dart';
import 'package:semur/helpers/nango_integration_helper.dart';

class ChatNangoConnectionSelectorModal extends StatefulWidget {
  final List<NangoConnectionPublic>? selectedConnections;
  final Function(List<NangoConnectionPublic> integrations)?
  onConnectionsSelected;

  const ChatNangoConnectionSelectorModal({
    super.key,
    this.selectedConnections,
    this.onConnectionsSelected,
  });

  @override
  State<ChatNangoConnectionSelectorModal> createState() =>
      _ChatNangoConnectionSelectorModalState();
}

class _ChatNangoConnectionSelectorModalState
    extends State<ChatNangoConnectionSelectorModal> {
  List<NangoConnectionPublic> availableUserConnections = [];
  List<NangoConnectionPublic> initialSelectedConnections = [];
  List<NangoConnectionPublic> _selectedConnections = [];

  List<NangoIntegration> integrationsConfigs = [];

  bool isLoading = false;

  Map<AgentCategory, int> numberOfIntegrationsPerAgentCategory = {
    AgentCategory.GENERAL: 3,
    AgentCategory.EMAIL: 1,
    AgentCategory.CALENDAR: 1,
  };

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      integrationsConfigs = await _fetchIntegrationsConfigs();
      availableUserConnections = await _fetchAvailableConnections();
      setState(() {
        isLoading = false;
      });
    });
    initialSelectedConnections = widget.selectedConnections ?? [];
    _selectedConnections = List.from(initialSelectedConnections);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    super.dispose();
  }

  Future<List<NangoIntegration>> _fetchIntegrationsConfigs() async {
    try {
      return await Application.accessors.appDataAccessor.getNangoIntegrations(
        callerRole: AppUser.currentCallerRole,
      );
    } catch (e) {
      Log.e("Error getting available integrations: ${e.toString()}");
      return [];
    }
  }

  Future<List<NangoConnectionPublic>> _fetchAvailableConnections() async {
    List<NangoConnectionPublic> userConnections = [];
    try {
      NangoUserConnectionsResponseWrapper responseWrapper =
          await NangoEngine.userConnections(
            isDev: Config.devMode,
            requestModel: NangoUserConnectionsRequestWrapper(
              userId: AppUser.user.id,
            ),
          );
      if (responseWrapper.isSuccess()) {
        userConnections = responseWrapper.response.connections;
      }
      return userConnections;
    } catch (e) {
      Log.e("Error getting user connections: ${e.toString()}");
      return [];
    }
  }

  List<AgentCategory> _getAgentCategory(NangoConnectionPublic connection) {
    for (NangoIntegration integration in integrationsConfigs) {
      if (integration.id == connection.id) {
        return integration.categories;
      }
    }
    return [AgentCategory.GENERAL];
  }

  Map<AgentCategory, int> _getSelectedCategoryCounts() {
    Map<AgentCategory, int> counts = {};
    for (var connection in _selectedConnections) {
      List<AgentCategory> categories = _getAgentCategory(connection);
      for (var category in categories) {
        counts[category] = (counts[category] ?? 0) + 1;
      }
    }
    return counts;
  }

  bool _canSelectConnection(NangoConnectionPublic connection) {
    if (_isConnectionSelected(connection.id)) {
      return true; // Already selected, can deselect
    }

    List<AgentCategory> categories = _getAgentCategory(connection);
    Map<AgentCategory, int> currentCounts = _getSelectedCategoryCounts();

    for (var category in categories) {
      int maxAllowed = numberOfIntegrationsPerAgentCategory[category] ?? 0;
      int currentCount = currentCounts[category] ?? 0;
      if (currentCount >= maxAllowed) {
        return false; // Would exceed limit for this category
      }
    }
    return true;
  }

  String _getCategoryLimitText() {
    Map<AgentCategory, int> currentCounts = _getSelectedCategoryCounts();
    List<String> limitTexts = [];
    
    numberOfIntegrationsPerAgentCategory.forEach((category, maxCount) {
      int currentCount = currentCounts[category] ?? 0;
      String categoryName = category.name.toLowerCase();
      categoryName = categoryName[0].toUpperCase() + categoryName.substring(1);
      limitTexts.add('$categoryName: $currentCount/$maxCount');
    });
    
    return limitTexts.join(' • ');
  }

  String _getStatusText(NangoConnectionStatus status) {
    switch (status) {
      case NangoConnectionStatus.NANGO_CONNECTION_ACTIVE:
        return 'ACTIVE';
      case NangoConnectionStatus.NANGO_CONNECTION_INACTIVE:
        return 'INACTIVE';
      case NangoConnectionStatus.NANGO_CONNECTION_CONNECTING:
        return 'CONNECTING';
      default:
        return 'INACTIVE';
    }
  }

  Color _getStatusColor(NangoConnectionStatus status) {
    switch (status) {
      case NangoConnectionStatus.NANGO_CONNECTION_ACTIVE:
        return AppColors.greenColor;
      case NangoConnectionStatus.NANGO_CONNECTION_INACTIVE:
        return AppColors.secondaryColor;
      case NangoConnectionStatus.NANGO_CONNECTION_CONNECTING:
        return AppColors.primaryColor;
      default:
        return AppColors.secondaryColor;
    }
  }

  void _toggleConnection(NangoConnectionPublic connection) {
    if (!_canSelectConnection(connection)) {
      return; // Cannot select this connection due to category limits
    }

    setState(() {
      if (_isConnectionSelected(connection.id)) {
        _selectedConnections.removeWhere((item) => item.id == connection.id);
      } else {
        _selectedConnections.add(connection);
      }
    });
  }

  Widget _buildConnectionsTable(List<NangoConnectionPublic> connections) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.lightGrayColor, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              color: AppColors.lightGrayColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Integration',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Select',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Connections
          ...connections.asMap().entries.map((entry) {
            final index = entry.key;
            final connection = entry.value;
            final isLast = index == connections.length - 1;
            final isSelected = _isConnectionSelected(connection.id);
            final canSelect = _canSelectConnection(connection);
            final isDisabled = !canSelect && !isSelected;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                    isLast
                        ? null
                        : Border(
                          bottom: BorderSide(
                            color: AppColors.lightGrayColor,
                            width: 0.5,
                          ),
                        ),
                borderRadius:
                    isLast
                        ? const BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        )
                        : null,
                color: isDisabled ? AppColors.lightGrayColor.withValues(alpha: 0.3) : null,
              ),
              child: Row(
                children: [
                  // Integration info (image + name + "Connected")
                  Expanded(
                    flex: 2,
                    child: Opacity(
                      opacity: isDisabled ? 0.5 : 1.0,
                      child: Row(
                        children: [
                          // Integration image
                          Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isDisabled 
                                    ? AppColors.lightGrayColor 
                                    : AppColors.primaryColor,
                                width: 1,
                              ),
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              NangoIntegrationHelper.getIntegrationImage(
                                connection.id,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Name and "Connected" status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatProviderName(connection.provider),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isDisabled 
                                        ? AppColors.lightDarkColor 
                                        : null,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isDisabled ? 'Limit reached' : 'Connected',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: isDisabled 
                                        ? AppColors.secondaryColor 
                                        : AppColors.greenColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Status
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _getStatusColor(
                            connection.status,
                          ).withValues(alpha: 0.1),
                        ),
                        child: Text(
                          _getStatusText(connection.status),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: _getStatusColor(connection.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Select checkbox
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: isDisabled ? null : () => _toggleConnection(connection),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            isSelected
                                ? CupertinoIcons.checkmark_circle_fill
                                : isDisabled
                                    ? CupertinoIcons.minus_circle
                                    : CupertinoIcons.circle,
                            color:
                                isSelected
                                    ? AppColors.primaryColor
                                    : isDisabled
                                        ? AppColors.lightGrayColor
                                        : AppColors.lightDarkColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _selectedConnections.clear();
    });
  }

  void _applySelection() {
    widget.onConnectionsSelected?.call(_selectedConnections);
    Navigator.of(context).pop();
  }

  bool _isConnectionSelected(String connectionId) {
    return _selectedConnections.any((item) => item.id == connectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightGrayColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Header
          Row(
            children: [
              Text(
                'Select Integrations',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (_selectedConnections.isNotEmpty) ...[
                TextButton(
                  onPressed: _clearAll,
                  child: Text(
                    'Clear All',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DefaultRoundedButton(
                  text: 'Apply',
                  press: _applySelection,
                  color: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  minHeight: 30,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          // Category limits information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.lightGrayColor.withValues(alpha: 0.3),
            ),
            child: Text(
              'Selection limits: ${_getCategoryLimitText()}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.lightDarkColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLoading) ...[
                  Center(
                    child: SpinKitWave(
                      color: AppColors.primaryColor,
                      size: 24.0,
                    ),
                  ),
                ],
                // Connected integrations table
                if (availableUserConnections.isNotEmpty) ...[
                  Text(
                    'Your Connected Integrations',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildConnectionsTable(availableUserConnections),
                  const SizedBox(height: 20),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatProviderName(String provider) {
    return provider
        .split('-')
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }
}
