import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/default_modal_bottom_sheet.dart';
import 'package:semur/helpers/nango_integration_helper.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:semur/modules/chat/widgets/chat_nango_connection_selector_modal.dart';
import 'package:semur/services/notification_service.dart';

class ChatInputComponent extends StatefulWidget {
  final TextEditingController messageController;
  final Function(
    String message,
    List<String> connectionIds,
    bool fastMode,
    bool proMode,
    AgentMood agentMood,
  )?
  onSendMessage;
  final bool isLoading;
  final bool needIntegrationSelected;

  const ChatInputComponent({
    super.key,
    required this.messageController,
    this.onSendMessage,
    this.isLoading = false,
    this.needIntegrationSelected = false,
  });

  @override
  State<ChatInputComponent> createState() => _ChatInputComponentState();
}

enum ChatMode { normal, fast, pro }

class _ChatInputComponentState extends State<ChatInputComponent> {
  final FocusNode _focusNode = FocusNode();
  final List<NangoConnectionPublic> _selectedConnections = [];
  ChatMode _currentMode = ChatMode.normal;
  AgentMood _currentAgentMood = AgentMood.NORMAL;

  // TODO: Hardcoded value
  final List<Map<String, dynamic>> _quickActions = [
    {
      'title': 'Summarize emails',
      'icon': CupertinoIcons.doc_text,
      'message': 'Can you summarize my emails for the last day?',
    },
    {
      'title': 'Important emails',
      'icon': CupertinoIcons.star,
      'message': 'Show me all latest important emails',
    },
    {
      'title': 'Sync emails',
      'icon': CupertinoIcons.clock,
      'message': 'Can you sync my emails?',
    },
  ];

  void _sendMessage() {
    if (integrationSelectionRequirement()) {
      showNotification(
        // TODO: Text
        "Please select an integration",
        NotificationType.error,
      );
      return;
    }

    final message = widget.messageController.text.trim();
    if (message.isNotEmpty &&
        widget.onSendMessage != null &&
        !widget.isLoading) {
      final connectionIds = _selectedConnections.map((e) => e.id).toList();
      final isFastMode = _currentMode == ChatMode.fast;
      final isProMode = _currentMode == ChatMode.pro;
      widget.onSendMessage!(
        message,
        connectionIds,
        isFastMode,
        isProMode,
        _currentAgentMood,
      );
      widget.messageController.clear();
    }
  }

  void _selectQuickAction(String message) {
    widget.messageController.text = message;
    _sendMessage();
  }

  void _showIntegrationSelector() {
    DefaultModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppColors.whiteColor,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
    ).show(
      ChatNangoConnectionSelectorModal(
        selectedConnections: _selectedConnections,
        onConnectionsSelected: (integrations) {
          setState(() {
            _selectedConnections.clear();
            _selectedConnections.addAll(integrations);
          });
        },
      ),
    );
  }

  void _removeConnection(String connectionId) {
    setState(() {
      _selectedConnections.removeWhere(
        (connection) => connection.id == connectionId,
      );
    });
  }

  @override
  void dispose() {
    widget.messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Message input with integration selector
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.lightGrayColor, width: 1),
              color: AppColors.darkWhiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick actions
                if (_quickActions.isNotEmpty) ...[
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;
                      
                      if (isSmallScreen) {
                        // Small screen layout: Quick actions carousel + collapsed settings button
                        return Column(
                          children: [
                            Row(
                              children: [
                                // Quick actions carousel
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: _quickActions.map((action) {
                                        return Container(
                                          margin: const EdgeInsets.only(right: 8),
                                          child: InkWell(
                                            onTap: widget.isLoading
                                                ? null
                                                : () => _selectQuickAction(action['message']),
                                            borderRadius: BorderRadius.circular(12),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: AppColors.primaryColor,
                                                  width: 1,
                                                ),
                                                color: AppColors.darkWhiteColor,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    action['icon'],
                                                    size: 16,
                                                    color: AppColors.secondaryColor,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    action['title'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: AppColors.primaryColor,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                // Collapsed settings button
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: PopupMenuButton<String>(
                                    offset: const Offset(0, -200),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.5,
                                        ),
                                        color: AppColors.darkWhiteColor,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.settings,
                                            size: 16,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 12,
                                            color: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem<String>(
                                        enabled: false,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Agent Mood',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primaryColor,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Wrap(
                                              spacing: 8,
                                              children: AgentMood.values.map((mood) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _currentAgentMood = mood;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(
                                                        color: _currentAgentMood == mood
                                                            ? _getMoodColor(mood)
                                                            : AppColors.lightGrayColor,
                                                        width: 1,
                                                      ),
                                                      color: _currentAgentMood == mood
                                                          ? _getMoodColor(mood).withOpacity(0.1)
                                                          : Colors.transparent,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          _getMoodIcon(mood),
                                                          size: 14,
                                                          color: _getMoodColor(mood),
                                                        ),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          _getMoodText(mood),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                color: _getMoodColor(mood),
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'Mode',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primaryColor,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: ChatMode.values.map((mode) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _currentMode = mode;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(right: 8),
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(
                                                        color: _currentMode == mode
                                                            ? AppColors.primaryColor
                                                            : AppColors.lightGrayColor,
                                                        width: 1,
                                                      ),
                                                      color: _currentMode == mode
                                                          ? AppColors.primaryColor.withOpacity(0.1)
                                                          : Colors.transparent,
                                                    ),
                                                    child: Text(
                                                      mode == ChatMode.normal
                                                          ? 'Normal'
                                                          : mode == ChatMode.fast
                                                              ? 'Fast'
                                                              : 'Pro',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: _currentMode == mode
                                                                ? AppColors.primaryColor
                                                                : AppColors.lightDarkColor,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Large screen layout: Original layout
                        return Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: _quickActions.map((action) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: widget.isLoading
                                            ? null
                                            : () => _selectQuickAction(action['message']),
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1,
                                            ),
                                            color: AppColors.darkWhiteColor,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                action['icon'],
                                                size: 16,
                                                color: AppColors.secondaryColor,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                action['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: AppColors.primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            // Agent Mood selector
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 0.5,
                                ),
                                color: AppColors.darkWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Mood',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: widget.isLoading
                                        ? null
                                        : () {
                                            setState(() {
                                              // Cycle through moods: normal -> deterministic -> careful -> creative -> wild -> normal
                                              switch (_currentAgentMood) {
                                                case AgentMood.NORMAL:
                                                  _currentAgentMood = AgentMood.DETERMINISTIC;
                                                  break;
                                                case AgentMood.DETERMINISTIC:
                                                  _currentAgentMood = AgentMood.CAREFUL;
                                                  break;
                                                case AgentMood.CAREFUL:
                                                  _currentAgentMood = AgentMood.CREATIVE;
                                                  break;
                                                case AgentMood.CREATIVE:
                                                  _currentAgentMood = AgentMood.WILD;
                                                  break;
                                                case AgentMood.WILD:
                                                  _currentAgentMood = AgentMood.NORMAL;
                                                  break;
                                              }
                                            });
                                          },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _getMoodColor(_currentAgentMood),
                                          width: 1,
                                        ),
                                        color: _getMoodColor(_currentAgentMood).withOpacity(0.1),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getMoodIcon(_currentAgentMood),
                                            size: 14,
                                            color: _getMoodColor(_currentAgentMood),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _getMoodText(_currentAgentMood),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: _getMoodColor(_currentAgentMood),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11,
                                                ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 10,
                                            color: _getMoodColor(_currentAgentMood).withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Mode selector (Normal, Fast, Pro)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 0.5,
                                ),
                                color: AppColors.darkWhiteColor,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Fast',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: widget.isLoading
                                        ? null
                                        : () {
                                            setState(() {
                                              // Cycle through modes: normal -> fast -> pro -> normal
                                              switch (_currentMode) {
                                                case ChatMode.normal:
                                                  _currentMode = ChatMode.fast;
                                                  break;
                                                case ChatMode.fast:
                                                  _currentMode = ChatMode.pro;
                                                  break;
                                                case ChatMode.pro:
                                                  _currentMode = ChatMode.normal;
                                                  break;
                                              }
                                            });
                                          },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      width: 66,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: _currentMode == ChatMode.normal
                                            ? AppColors.lightGrayColor
                                            : AppColors.primaryColor,
                                      ),
                                      child: Stack(
                                        children: [
                                          AnimatedAlign(
                                            duration: const Duration(milliseconds: 200),
                                            alignment: _currentMode == ChatMode.fast
                                                ? Alignment.centerLeft
                                                : _currentMode == ChatMode.pro
                                                    ? Alignment.centerRight
                                                    : Alignment.center,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _currentMode == ChatMode.normal
                                                    ? AppColors.primaryColor
                                                    : AppColors.whiteColor,
                                              ),
                                              child: Icon(
                                                _currentMode == ChatMode.fast
                                                    ? CupertinoIcons.bolt_fill
                                                    : _currentMode == ChatMode.pro
                                                        ? CupertinoIcons.star_fill
                                                        : CupertinoIcons.circle,
                                                size: 12,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Quality',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    // Integration selector button
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap:
                            widget.isLoading ? null : _showIntegrationSelector,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _selectedConnections.isNotEmpty
                                    ? AppColors.primaryColor.withOpacity(0.1)
                                    : AppColors.lightGrayColor.withOpacity(0.5),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child:
                              _selectedConnections.isEmpty
                                  ? Icon(
                                    Icons.extension,
                                    color: AppColors.lightDarkColor,
                                    size: 20,
                                  )
                                  : Center(
                                    child: Text(
                                      '${_selectedConnections.length}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Text input
                    Expanded(
                      child: Focus(
                        onKeyEvent: (FocusNode node, KeyEvent event) {
                          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
                            if (!HardwareKeyboard.instance.isShiftPressed) {
                              _sendMessage();
                              return KeyEventResult.handled;
                            }
                          }
                          return KeyEventResult.ignored;
                        },
                        child: TextField(
                          controller: widget.messageController,
                          focusNode: _focusNode,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText:
                                _selectedConnections.isNotEmpty
                                    ? 'Ask about ${_selectedConnections.first.provider}${_selectedConnections.length > 1 ? ' and ${_selectedConnections.length - 1} more' : ''}...'
                                    : 'Type your message...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.lightDarkColor),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          enabled: !widget.isLoading,
                          onSubmitted: null,
                        ),
                      ),
                    ),
                    // Send button
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        onTap: widget.isLoading ? null : _sendMessage,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                widget.isLoading
                                    ? AppColors.lightGrayColor
                                    : AppColors.primaryColor,
                          ),
                          child:
                              widget.isLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                  )
                                  : Icon(
                                    CupertinoIcons.arrow_up,
                                    color: AppColors.whiteColor,
                                    size: 20,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Integration badges
                if (_selectedConnections.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          _selectedConnections.map((connection) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.primaryColor.withOpacity(0.1),
                                border: Border.all(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    NangoIntegrationHelper.getIntegrationImage(
                                      connection.id,
                                    ),
                                    height: 14,
                                    width: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    NangoIntegrationHelper.getConnectionProviderName(
                                      connection.id,
                                    ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap:
                                        () => _removeConnection(connection.id),
                                    child: Icon(
                                      CupertinoIcons.xmark,
                                      size: 12,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool integrationSelectionRequirement() {
    return widget.needIntegrationSelected && _selectedConnections.isEmpty;
  }

  Color _getMoodColor(AgentMood mood) {
    switch (mood) {
      case AgentMood.NORMAL:
        return AppColors.primaryColor;
      case AgentMood.DETERMINISTIC:
        return Colors.blue;
      case AgentMood.CAREFUL:
        return Colors.orange;
      case AgentMood.CREATIVE:
        return Colors.purple;
      case AgentMood.WILD:
        return Colors.red;
      default:
        return AppColors.primaryColor;
    }
  }

  IconData _getMoodIcon(AgentMood mood) {
    switch (mood) {
      case AgentMood.NORMAL:
        return CupertinoIcons.person;
      case AgentMood.DETERMINISTIC:
        return CupertinoIcons.gear;
      case AgentMood.CAREFUL:
        return CupertinoIcons.shield;
      case AgentMood.CREATIVE:
        return CupertinoIcons.lightbulb;
      case AgentMood.WILD:
        return CupertinoIcons.flame;
      default:
        return CupertinoIcons.person;
    }
  }

  String _getMoodText(AgentMood mood) {
    switch (mood) {
      case AgentMood.NORMAL:
        return 'Normal';
      case AgentMood.DETERMINISTIC:
        return 'Logic';
      case AgentMood.CAREFUL:
        return 'Safe';
      case AgentMood.CREATIVE:
        return 'Creative';
      case AgentMood.WILD:
        return 'Wild';
      default:
        return 'Normal';
    }
  }
}
