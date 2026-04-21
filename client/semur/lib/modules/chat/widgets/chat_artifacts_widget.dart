import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/modules/chat/widgets/email_detail_overlay.dart';
import 'package:semur/modules/chat/widgets/mentioned_email_card.dart';

class ChatArtifactsWidget extends StatefulWidget {
  final ChatArtifacts artifacts;

  const ChatArtifactsWidget({
    super.key,
    required this.artifacts,
  });

  @override
  State<ChatArtifactsWidget> createState() => _ChatArtifactsWidgetState();
}

class _ChatArtifactsWidgetState extends State<ChatArtifactsWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if we have any artifacts to display
    bool hasEmailArtifacts =
        widget.artifacts.hasEmailAssistant() &&
        widget.artifacts.emailAssistant.mentionedEmails.isNotEmpty;

    if (!hasEmailArtifacts) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artifacts header
          Row(
            children: [
              Icon(
                CupertinoIcons.layers,
                size: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Related Content',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Mentioned emails
          if (hasEmailArtifacts) ...[
            SizedBox(
              height: 180,
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 2),
                  itemCount:
                      widget.artifacts.emailAssistant.mentionedEmails.length,
                  itemBuilder: (context, index) {
                    final email =
                        widget.artifacts.emailAssistant.mentionedEmails[index];
                    return MentionedEmailCard(
                      email: email,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          builder: (BuildContext context) {
                            return EmailDetailOverlay(email: email);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
