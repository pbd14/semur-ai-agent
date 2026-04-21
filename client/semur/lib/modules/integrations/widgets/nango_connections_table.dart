import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/helpers/nango_integration_helper.dart';
import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:intl/intl.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';
import 'package:semur/semur_engine/syncs/google-calendar_sync_engine.dart';
import 'package:semur/semur_engine/syncs/google-mail_sync_engine.dart';
import 'package:semur/semur_engine/syncs/outlook-mail_sync_engine.dart';
import 'package:semur/services/notification_service.dart';

class NangoConnectionsTable extends StatefulWidget {
  final List<NangoConnectionPublic> connections;
  final Map<String, SyncInformation?> syncInfoMap;
  final Function(String connectionId)? onSync;
  final Function(String connectionId)? onDelete;

  const NangoConnectionsTable({
    super.key,
    required this.connections,
    required this.syncInfoMap,
    this.onSync,
    this.onDelete,
  });

  @override
  State<NangoConnectionsTable> createState() => _NangoConnectionsTableState();
}

class _NangoConnectionsTableState extends State<NangoConnectionsTable> {
  Map<String, bool> loadingStatusPerConnection = {};
  String _formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  String _getStatusText(NangoConnectionStatus status) {
    // TODO: Text
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

  String _getSyncStatusText(SyncStatus? status) {
    if (status == null) return 'N/A';
    switch (status) {
      case SyncStatus.PENDING:
        return 'PENDING';
      case SyncStatus.IN_PROGRESS:
        return 'IN PROGRESS';
      case SyncStatus.COMPLETED:
        return 'COMPLETED';
      case SyncStatus.FAILED:
        return 'FAILED';
      case SyncStatus.PARTIALLY_COMPLETED:
        return 'PARTIALLY COMPLETED';
      default:
        return 'N/A';
    }
  }

  Color _getSyncStatusColor(SyncStatus? status) {
    if (status == null) return AppColors.lightDarkColor;
    switch (status) {
      case SyncStatus.PENDING:
        return AppColors.primaryColor;
      case SyncStatus.IN_PROGRESS:
        return AppColors.primaryColor;
      case SyncStatus.COMPLETED:
        return AppColors.greenColor;
      case SyncStatus.FAILED:
        return Colors.red;
      case SyncStatus.PARTIALLY_COMPLETED:
        return Colors.orange;
      default:
        return AppColors.lightDarkColor;
    }
  }

  Future<void> syncIntegration(NangoConnectionPublic connection) async {
    setState(() {
      loadingStatusPerConnection[connection.id] = true;
    });
    try {
      dynamic responseWrapper;
      switch (connection.id) {
        case 'google-mail':
          responseWrapper = await SyncGoogleMailEngine.emails(
            isDev: Config.devMode,
            requestModel:
                SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper(
                  userId: connection.userId,
                  integrationId: connection.id,
                ),
          );
          break;
        case 'google-calendar':
          responseWrapper = await SyncGoogleCalendarEngine.events(
            isDev: Config.devMode,
            requestModel:
                SyncGoogleCalendarEventsFromNangoToFirestoreRequestWrapper(
                  userId: connection.userId,
                  integrationId: connection.id,
                ),
          );
          break;
        case 'outlook-mail':
          responseWrapper = await SyncOutlookMailEngine.emails(
            isDev: Config.devMode,
            requestModel:
                SyncOutlookMailEmailsFromNangoToFirestoreRequestWrapper(
                  userId: connection.userId,
                  integrationId: connection.id,
                ),
          );
          break;
      }
      if (responseWrapper != null && responseWrapper.isSuccess()) {
        SyncInformation newSyncInformation = await Application
            .accessors
            .userSyncGoogleMailAccessor
            .getSyncInfo(
              userId: connection.userId,
              nangoIntegrationId: connection.id,
              callerRole: AppUser.currentCallerRole,
            );
        setState(() {
          widget.syncInfoMap[connection.id] = newSyncInformation;
        });
        showNotification(
          // TODO: Text
          'Sync successful',
          NotificationType.success,
        );
      } else {
        Log.e("Error syncing emails: ${responseWrapper.response}");
        showNotification(
          Application.appLocalizations!.errorTryAgainLater,
          NotificationType.error,
        );
      }
    } catch (e) {
      showNotification(
        Application.appLocalizations!.errorTryAgainLater,
        NotificationType.error,
      );
    }
    setState(() {
      loadingStatusPerConnection[connection.id] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.connections.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          // TODO: Text
          'No connections yet',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.lightDarkColor),
          textAlign: TextAlign.center,
        ),
      );
    }

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
                    'Sync Updated',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Sync Status',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Actions',
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
          ...widget.connections.asMap().entries.map((entry) {
            final index = entry.key;
            final connection = entry.value;
            final syncInfo = widget.syncInfoMap[connection.id];
            final isLast = index == widget.connections.length - 1;

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
              ),
              child:
                  loadingStatusPerConnection[connection.id] == true
                      ? Center(
                        child: SpinKitWave(
                          color: AppColors.primaryColor,
                          size: 20.0,
                        ),
                      )
                      : Row(
                        children: [
                          // Integration info (image + name + last updated)
                          Expanded(
                            flex: 2,
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
                                      color: AppColors.primaryColor,
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
                                // Name and last updated
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        NangoIntegrationHelper.getConnectionProviderName(
                                          connection.id,
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Updated: ${connection.hasUpdatedAt() ? _formatDate(connection.updatedAt.toDateTime()) : 'Never'}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: AppColors.lightDarkColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                  ).withOpacity(0.1),
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
                          // Sync Updated
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                syncInfo?.hasUpdatedAt() == true
                                    ? _formatDate(
                                      syncInfo!.updatedAt.toDateTime(),
                                    )
                                    : 'N/A',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.lightDarkColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // Sync Status
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
                                  color: _getSyncStatusColor(
                                    syncInfo?.status,
                                  ).withOpacity(0.1),
                                ),
                                child: Text(
                                  _getSyncStatusText(syncInfo?.status),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: _getSyncStatusColor(
                                      syncInfo?.status,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Actions
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Manage button
                                DefaultRoundedButton(
                                  text: 'Sync',
                                  press:
                                      widget.onSync != null
                                          ? () => widget.onSync!(connection.id)
                                          : () => syncIntegration(connection),
                                  color: AppColors.primaryColor,
                                  textColor: AppColors.whiteColor,
                                  borderRadius: 8,
                                  padding: 6,
                                  minHeight: 32,
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Delete button
                                DefaultRoundedButton(
                                  text:
                                      Application.appLocalizations?.delete ??
                                      'Delete',
                                  press:
                                      widget.onDelete != null
                                          ? () =>
                                              widget.onDelete!(connection.id)
                                          : null,
                                  color: AppColors.secondaryColor,
                                  textColor: AppColors.whiteColor,
                                  borderRadius: 8,
                                  padding: 6,
                                  minHeight: 32,
                                  textStyle: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
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
}
