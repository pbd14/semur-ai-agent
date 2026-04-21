import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/widgets/custom_dialog.dart';
import 'package:semur/models.pb/external_apps/external_app.pb.dart';

class ExternalAppIntegrationCard extends StatefulWidget {
  final ExternalAppIntegration integration;
  final VoidCallback? onDelete;

  const ExternalAppIntegrationCard({
    super.key,
    required this.integration,
    this.onDelete,
  });

  @override
  State<ExternalAppIntegrationCard> createState() =>
      _ExternalAppIntegrationCardState();
}

class _ExternalAppIntegrationCardState
    extends State<ExternalAppIntegrationCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    Log.w("ExternalAppIntegrationCard initialized + ${widget.integration.id}");
    super.initState();
  }

  String _getAppTypeDisplayName(ExternalAppType type) {
    switch (type) {
      case ExternalAppType.TELEGRAM_BOT:
        return 'Telegram Bot';
      default:
        return type.name;
    }
  }

  String _getAppTypeIcon(ExternalAppType type) {
    switch (type) {
      case ExternalAppType.TELEGRAM_BOT:
        return 'assets/icons/telegram.png';
      default:
        return 'assets/icons/Logo512.png';
    }
  }

  Color _getStatusColor(ExternalAppIntegrationStatus status) {
    switch (status) {
      case ExternalAppIntegrationStatus.ACTIVE:
        return Colors.green;
      case ExternalAppIntegrationStatus.INACTIVE:
        return Colors.orange;
      case ExternalAppIntegrationStatus.DELETED:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(ExternalAppIntegrationStatus status) {
    switch (status) {
      case ExternalAppIntegrationStatus.ACTIVE:
        return 'Active';
      case ExternalAppIntegrationStatus.INACTIVE:
        return 'Inactive';
      case ExternalAppIntegrationStatus.DELETED:
        return 'Deleted';
      default:
        return status.name;
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          // TODO: Text
          title: "Delete Integration?",
          // TODO: Text
          text:
              "Are you sure you want to delete this ${_getAppTypeDisplayName(widget.integration.type)} integration? This action cannot be undone.",
          showNo: true,
          onSubmitted: () {
            Navigator.of(context).pop(true);
            widget.onDelete?.call();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor, width: 1),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          // Main card content
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // App icon
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGrayColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _getAppTypeIcon(widget.integration.type),
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 36,
                            height: 36,
                            color: AppColors.lightGrayColor,
                            child: Icon(
                              CupertinoIcons.app,
                              color: AppColors.secondaryColor,
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // App info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getAppTypeDisplayName(widget.integration.type),
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "#${widget.integration.id}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _getStatusColor(
                                  widget.integration.status,
                                ).withOpacity(0.1),
                              ),
                              child: Text(
                                _getStatusText(widget.integration.status),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: _getStatusColor(
                                    widget.integration.status,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Actions
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Delete button
                      IconButton(
                        onPressed:
                            widget.onDelete != null
                                ? () {
                                  _showDeleteConfirmation(context);
                                }
                                : null,
                        icon: Icon(
                          CupertinoIcons.trash,
                          color: Colors.red,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                      // Expand/collapse button
                      Icon(
                        _isExpanded
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        color: AppColors.secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded metadata section
          if (_isExpanded && widget.integration.metadata.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.lightGrayColor, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metadata',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.integration.metadata.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              '${entry.key}:',
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_isExpanded && widget.integration.metadata.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.lightGrayColor, width: 1),
                ),
              ),
              child: Center(
                child: Text(
                  'No metadata available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
