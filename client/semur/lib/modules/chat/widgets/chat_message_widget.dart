import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/modules/chat/widgets/chat_artifacts_widget.dart';

class ChatMessageWidget extends StatefulWidget {
  final ChatMessage message;
  final Function(String)? onFollowUpQuestion;
  final bool animateText;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.onFollowUpQuestion,

    this.animateText = true,
  });

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget>
    with TickerProviderStateMixin {
  late AnimationController _typeController;
  String _displayedText = '';
  bool _showFollowUps = false;

  // Sample function to convert text to markdown html
  void convertMarkdown() {}

  @override
  void initState() {
    super.initState();


    _typeController = AnimationController(
      duration: Duration(
        milliseconds: min(widget.message.content.length * 20, 300),
      ),
      vsync: this,
    );
    _startAnimation();
  }

  void _startAnimation() {

    if (widget.animateText && widget.message.role != ChatRole.TOOL) { 
      _animateText();
    } else {
      _displayedText = widget.message.content;
      _showFollowUps = true;
    }
  }

  void _animateText() {
    final text = widget.message.content;
    final duration = Duration(
      milliseconds: min(widget.message.content.length * 20, 300),
    );

    _typeController.duration = duration;

    _typeController.addListener(() {
      final progress = _typeController.value;
      final charactersToShow = (text.length * progress).round();

      setState(() {
        _displayedText = text.substring(0, charactersToShow);
      });
    });

    _typeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showFollowUps = true;
        });
      }
    });

    _typeController.forward();
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.role == ChatRole.USER;
    final isModel = widget.message.role == ChatRole.MODEL;
    final isTool = widget.message.role == ChatRole.TOOL;

    // Special UI for tool calls
    if (isTool) {
      return _buildToolCallWidget(context);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isUser ? AppColors.primaryColor : AppColors.lightGrayColor,
            ),
            child: Icon(
              isUser ? CupertinoIcons.person_fill : CupertinoIcons.sparkles,
              size: 18,
              color: isUser ? AppColors.whiteColor : AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          // Message content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author name
                if (widget.message.hasAuthor() &&
                    widget.message.author.isNotEmpty) ...[
                  Text(
                    widget.message.author,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.lightDarkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                // Message content
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkWhiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        isModel
                            ? Border.all(
                              color: AppColors.lightGrayColor,
                              width: 1.5,
                            )
                            : Border.all(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message text with typing animation
                      SelectionArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: MarkdownGenerator().buildWidgets(
                            _displayedText,
                            config: MarkdownConfig(
                              configs: [
                            // Blockquote
                            BlockquoteConfig(
                              sideColor: AppColors.secondaryColor,
                              textColor: const Color(0xff57606a),
                              sideWith: 4.0,
                              padding: const EdgeInsets.fromLTRB(16, 2, 0, 2),
                              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            ),
                            // Paragraph styling to match UI text
                            PConfig(
                              textStyle:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color:
                                        isUser
                                            ? AppColors.darkColor
                                            : AppColors.darkColor,
                                  ) ??
                                  const TextStyle(),
                            ),
                            // Heading styles matching your theme
                            H1Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ) ??
                                  const TextStyle(),
                            ),
                            H2Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ) ??
                                  const TextStyle(),
                            ),
                            H3Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ) ??
                                  const TextStyle(),
                            ),
                            H4Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ) ??
                                  const TextStyle(),
                            ),
                            H5Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ) ??
                                  const TextStyle(),
                            ),
                            H6Config(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ) ??
                                  const TextStyle(),
                            ),
                            // Code block styling
                            // PreConfig(
                            //   decoration: BoxDecoration(
                            //     color: AppColors.lightGrayColor.withValues(
                            //       alpha: 0.3,
                            //     ),
                            //     borderRadius: BorderRadius.circular(8),
                            //     border: Border.all(
                            //       color: AppColors.lightGrayColor,
                            //       width: 1,
                            //     ),
                            //   ),
                            //   padding: const EdgeInsets.all(12),
                            //   textStyle:
                            //       Theme.of(
                            //         context,
                            //       ).textTheme.bodySmall?.copyWith(
                            //         fontFamily: 'monospace',
                            //         color: AppColors.darkColor,
                            //       ) ??
                            //       const TextStyle(),
                            // ),
                            // Inline code styling
                            // CodeConfig(
                            //   style:
                            //       Theme.of(
                            //         context,
                            //       ).textTheme.bodyMedium?.copyWith(
                            //         fontFamily: 'monospace',
                            //         backgroundColor: AppColors.secondaryColor,
                            //         color: AppColors.primaryColor,
                            //       ) ??
                            //       const TextStyle(),
                            // ),
                            // Link styling
                            LinkConfig(
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.secondaryColor,
                                    decoration: TextDecoration.none,
                                  ) ??
                                  const TextStyle(),
                            ),
                            // List styling
                            // ListConfig(
                            //   marker: (isOrdered, depth, index) {
                            //     if (isOrdered) {
                            //       return Text(
                            //         '${index + 1}. ',
                            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            //           color: AppColors.primaryColor,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       );
                            //     } else {
                            //       return Text(
                            //         '•',
                            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            //           color: AppColors.primaryColor,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       );
                            //     }
                            //   },
                            // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Artifacts
                      if (widget.message.hasArtifacts() &&
                          _showFollowUps) ...[
                        ChatArtifactsWidget(
                          artifacts: widget.message.artifacts,
                        ),
                      ],
                      // Follow-up questions
                      if (_showFollowUps &&
                          widget.message.followUpQuestions.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        AnimatedOpacity(
                          opacity: _showFollowUps ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Follow-up questions:',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: AppColors.lightDarkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...widget.message.followUpQuestions.map(
                                (question) => Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  child: InkWell(
                                    onTap:
                                        widget.onFollowUpQuestion != null
                                            ? () => widget
                                                .onFollowUpQuestion!(question)
                                            : null,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                        border: Border.all(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.3),
                                          width: 1,
                                        ),
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.05),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.chat_bubble,
                                            size: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 6),
                                          Flexible(
                                            child: Text(
                                              question,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCallWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tool icon with connecting line
          Column(
            children: [
               // Connecting line for visual flow
              Container(
                width: 2,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.gear_alt,
                  size: 12,
                  color: AppColors.primaryColor,
                ),
              ),
              // Connecting line for visual flow
              Container(
                width: 2,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Tool call content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tool call header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.function,
                            size: 12,
                            color: AppColors.secondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            // TODO: Text
                            'Tool Execution',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.message.hasAuthor() &&
                        widget.message.author.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.message.author,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
