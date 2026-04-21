import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/external_apps/external_app.pb.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pb.dart';

class AddExternalAppIntegrationModal extends StatelessWidget {
  final ExternalAppIntegration integration;
  final TelegramBotIntegration? telegramBotIntegration;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const AddExternalAppIntegrationModal({
    super.key,
    required this.integration,
    this.telegramBotIntegration,
    required this.onConfirm,
    required this.onCancel,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Add Integration',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onCancel,
                icon: Icon(
                  CupertinoIcons.xmark,
                  color: AppColors.secondaryColor,
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Integration preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrayColor, width: 1),
              color: AppColors.darkWhiteColor,
            ),
            child: Row(
              children: [
                // App icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.lightGrayColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      _getAppTypeIcon(integration.type),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 48,
                          height: 48,
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
                        _getAppTypeDisplayName(integration.type),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "@${telegramBotIntegration?.username ?? ""}",
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Ready to connect',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Confirmation message
          Text(
            'Do you want to add this integration to your external apps?',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryColor,
                    side: BorderSide(color: AppColors.lightGrayColor),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Add Integration',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
