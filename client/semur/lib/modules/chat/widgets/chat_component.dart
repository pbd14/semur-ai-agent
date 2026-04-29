import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/modules/chat/widgets/chat_message_widget.dart';
import 'package:semur/modules/chat/widgets/chat_input_component.dart';
import 'package:semur/modules/chat/widgets/chat_message_shimmer.dart';

class ChatComponent extends StatefulWidget {
  final List<ChatMessage> messages;
  final Function(
    String message,
    List<String> integrationIds,
    bool fastMode,
    bool proMode,
    AgentMood agentMood,
  )?
  onSendMessage;
  final bool isLoading;
  final String? currentSessionId;
  final bool needIntegrationSelected;

  const ChatComponent({
    super.key,
    required this.messages,
    this.onSendMessage,
    this.isLoading = false,
    this.currentSessionId,
    this.needIntegrationSelected = true,
  });

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final ScrollController _scrollController = ScrollController();
  final Set<int> _animatedMessages = <int>{};
  final TextEditingController _messageController = TextEditingController();
  Timer? _scrollRetryTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(ChatComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Clean up animated messages set for messages that no longer exist
    final currentMessageIds = widget.messages.map((m) => m.id).toSet();
    _animatedMessages.retainWhere((id) => currentMessageIds.contains(id));

    if (widget.messages.length != oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
    // Also scroll when messages are first loaded (from empty to non-empty)
    if (oldWidget.messages.isEmpty && widget.messages.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollRetryTimer?.cancel();
    if (_scrollController.hasClients) {
      // With reverse: true, scrolling to 0 means showing the latest messages
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If no clients yet, try again after a delay
      _scrollRetryTimer = Timer(const Duration(milliseconds: 100), () {
        if (!mounted) {
          return;
        }
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollRetryTimer?.cancel();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      // When no messages, show empty state with input closer to center
      return Column(
        children: [
          Expanded(child: _buildEmptyState()),
          if (widget.onSendMessage != null)
            ChatInputComponent(
              needIntegrationSelected: widget.needIntegrationSelected,
              messageController: _messageController,
              onSendMessage: widget.onSendMessage,
              isLoading: widget.isLoading,
            ),
        ],
      );
    } else {
      // When messages exist, show scrollable messages with input fixed at bottom
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              key: ValueKey(widget.messages.length),
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.messages.length + (widget.isLoading ? 1 : 0),
              reverse: true, // This makes the list start from bottom
              itemBuilder: (context, index) {
                // If this is the loading indicator item (always at index 0 when reverse: true)
                if (widget.isLoading && index == 0) {
                  return const ChatMessageShimmer();
                }

                // Adjust index for shimmer when loading
                final adjustedIndex = widget.isLoading ? index - 1 : index;
                // Reverse the index since we're using reverse: true
                final actualIndex = widget.messages.length - 1 - adjustedIndex;
                final message = widget.messages[actualIndex];
                final shouldAnimate = !_animatedMessages.contains(message.id);

                // Mark this message as animated after first render
                if (shouldAnimate) {
                  _animatedMessages.add(message.id);
                }

                return ChatMessageWidget(
                  key: ValueKey(message.id),
                  message: message,
                  onFollowUpQuestion: (String text) {
                    _messageController.text = text;
                  },
                  animateText: shouldAnimate,
                );
              },
            ),
          ),
          if (widget.onSendMessage != null)
            ChatInputComponent(
              needIntegrationSelected: widget.needIntegrationSelected,
              messageController: _messageController,
              onSendMessage: widget.onSendMessage,
              isLoading: widget.isLoading,
            ),
        ],
      );
    }
  }

  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 280;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(isCompact ? 16 : 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isCompact) ...[
                      Image.asset("assets/icons/Logo512.png", width: 80),
                      const SizedBox(height: 24),
                    ],
                    Text(
                      'Start a conversation',
                      style: (isCompact
                              ? Theme.of(context).textTheme.titleMedium
                              : Theme.of(context).textTheme.headlineSmall)
                          ?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (!isCompact) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Ask questions, get summaries, or manage your integrations using AI assistance.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.lightDarkColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.lightGrayColor.withValues(
                            alpha: 0.5,
                          ),
                          border: Border.all(
                            color: AppColors.lightGrayColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.lightbulb,
                                  size: 16,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Try asking:',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '• "Summarize my emails from today"\n'
                              '• "Show me important messages"\n'
                              '• "What integrations do I have?"',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.lightDarkColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
