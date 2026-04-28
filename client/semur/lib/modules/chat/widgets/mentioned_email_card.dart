import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/agents/email_assistant.pb.dart';

class MentionedEmailCard extends StatelessWidget {
  final EmailAssistantMentionedEmail email;
  final VoidCallback? onTap;

  const MentionedEmailCard({super.key, required this.email, this.onTap});

  String providerLabel(String provider) {
    switch (provider) {
      case 'gmail':
        return 'Gmail';
      case 'outlook':
        return 'Outlook';
      case 'yahoo':
        return 'Yahoo';
      default:
        return 'Email';
    }
  }

  String importanceScoreLabel(double score) {
    // TODO: Text
    if (score >= 0.8) return 'Very Important';
    if (score >= 0.6) return 'Important';
    if (score >= 0.4) return 'Less Important';
    return 'Not Important';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGrayColor, width: 1),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with provider and importance
              Row(
                children: [
                  // Provider indicator
                  if (email.hasProvider() && email.provider.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        email.provider.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Importance score
                  if (email.hasImportanceScore()) ...[
                    ImportanceLabelBadge(
                      importanceScore: email.importanceScore,
                    ),
                  ],
                  const Spacer(),
                  Icon(
                    CupertinoIcons.mail,
                    size: 16,
                    color: AppColors.lightDarkColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Subject
              if (email.hasSubject() && email.subject.isNotEmpty) ...[
                Text(
                  email.subject,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
              ],

              // Sender info
              if (email.hasSenderName() || email.hasSenderEmail()) ...[
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.person_circle,
                      size: 14,
                      color: AppColors.lightDarkColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        email.hasSenderName() && email.senderName.isNotEmpty
                            ? email.senderName
                            : email.hasSenderEmail()
                            ? email.senderEmail
                            : 'Unknown sender',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.lightDarkColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Snippet
              if (email.hasSnippet() && email.snippet.isNotEmpty) ...[
                Text(
                  email.snippet,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightDarkColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              Spacer(),

              // Bottom row with date and labels
              Row(
                children: [
                  // Date
                  if (email.hasDate() && email.date.isNotEmpty) ...[
                    Icon(
                      CupertinoIcons.clock,
                      size: 12,
                      color: AppColors.lightDarkColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(email.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightDarkColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    // Simple date formatting - you might want to use intl package for better formatting
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${date.day}/${date.month}';
      }
    } catch (e) {
      return dateString;
    }
  }
}

class ImportanceLabelBadge extends StatelessWidget {
  final double importanceScore;

  const ImportanceLabelBadge({super.key, required this.importanceScore});

  String _getImportanceLabel() {
    if (importanceScore >= 0.8) return 'Very Important';
    if (importanceScore >= 0.6) return 'Important';
    if (importanceScore >= 0.4) return 'Less Important';
    return 'Not Important';
  }

  Color _getImportanceColor() {
    if (importanceScore >= 0.8) return AppColors.secondaryColor;
    if (importanceScore >= 0.6) return Colors.orange;
    if (importanceScore >= 0.4) return Colors.amber;
    return AppColors.lightDarkColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _getImportanceColor().withValues(alpha: 0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.star_fill,
            size: 12,
            color: _getImportanceColor(),
          ),
          const SizedBox(width: 4),
          Text(
            _getImportanceLabel(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getImportanceColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
