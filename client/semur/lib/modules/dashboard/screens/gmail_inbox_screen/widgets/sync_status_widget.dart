import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';

class SyncStatusWidget extends StatelessWidget {
  final SyncInformation? syncInformation;
  final VoidCallback? onSync;

  const SyncStatusWidget({super.key, this.syncInformation, this.onSync});

  Color _getStatusColor() {
    if (syncInformation == null) return Colors.grey;

    switch (syncInformation!.status) {
      case SyncStatus.PENDING:
        return Colors.orange;
      case SyncStatus.IN_PROGRESS:
        return AppColors.primaryColor;
      case SyncStatus.COMPLETED:
        return AppColors.greenColor;
      case SyncStatus.FAILED:
        return Colors.red;
      case SyncStatus.PARTIALLY_COMPLETED:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    if (syncInformation == null) return 'NO STATUS';

    switch (syncInformation!.status) {
      case SyncStatus.PENDING:
        return 'PENDING';
      case SyncStatus.IN_PROGRESS:
        return 'IN PROGRESS';
      case SyncStatus.COMPLETED:
        return 'COMPLETED';
      case SyncStatus.FAILED:
        return 'FAILED';
      case SyncStatus.PARTIALLY_COMPLETED:
        return 'PARTIAL';
      default:
        return 'UNKNOWN';
    }
  }

  bool get _shouldShowLoadingIndicator {
    if (syncInformation == null) return false;
    return syncInformation!.status == SyncStatus.PENDING ||
        syncInformation!.status == SyncStatus.IN_PROGRESS;
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Gmail icon
            Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey[300]!, width: 0.5),
              ),
              child: Image.asset(
                'assets/vendors/gmail.png',
                width: 24,
                height: 24,
              ),
            ),
      
            const SizedBox(width: 10),
      
            // Provider name
            SizedBox(
              width: 60,
              child: Text(
                'Gmail',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
            ),
      
            const SizedBox(width: 12),
      
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _getStatusColor().withOpacity(0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_shouldShowLoadingIndicator) ...[
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getStatusColor(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(width: 12),
      
            // Last updated
            Flexible(
              child: Text(
                syncInformation?.hasUpdatedAt() == true
                    ? _formatDate(
                      DateTime.fromMillisecondsSinceEpoch(
                        syncInformation!.updatedAt.seconds.toInt() * 1000,
                      ),
                    )
                    : 'Never synced',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ),
            SizedBox(width: 12),
      
            // Sync button
            if (onSync != null)
              DefaultRoundedButton(
                text: 'Sync',
                press: _shouldShowLoadingIndicator ? null : onSync,
                color: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
                borderRadius: 8,
                padding: 6,
                minHeight: 32,
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
