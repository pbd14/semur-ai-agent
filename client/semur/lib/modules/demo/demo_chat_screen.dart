import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart';
import 'package:semur/modules/chat/widgets/chat_component.dart';
import 'package:semur/semur_engine/agents/email_assistant_engine.dart';

typedef DemoChatClient =
    Future<DemoChatResult> Function({
      required String userMessage,
      required String sessionId,
    });

class DemoChatResult {
  final String chatOutput;
  final String agentTraceOutput;

  const DemoChatResult({
    required this.chatOutput,
    required this.agentTraceOutput,
  });

  factory DemoChatResult.fromEngine(AgentDemoChatOutputWrapper wrapper) {
    return DemoChatResult(
      chatOutput: wrapper.chatOutput,
      agentTraceOutput: wrapper.agentTraceOutput,
    );
  }
}

@RoutePage()
class DemoChatScreen extends StatefulWidget {
  static const samplePrompt =
      'Review my inbox and calendar for tomorrow. Identify urgent emails, '
      'find scheduling conflicts, and draft responses for anything that needs '
      'action before noon.';

  final DemoChatClient? demoChatClient;

  const DemoChatScreen({
    super.key,
    this.demoChatClient,
  });

  @override
  State<DemoChatScreen> createState() => _DemoChatScreenState();
}

class _DemoChatScreenState extends State<DemoChatScreen> {
  final String _sessionId =
      'demo-${DateTime.now().millisecondsSinceEpoch.toString()}';
  final List<ChatMessage> _messages = [];
  int _nextMessageId = 1;
  bool _isLoading = false;

  Future<DemoChatResult> _defaultDemoChatClient({
    required String userMessage,
    required String sessionId,
  }) async {
    final response = await AgentEmailAssistantEngine.demoChat(
      isDev: Config.devMode,
      userMessage: userMessage,
      sessionId: sessionId,
    );
    return DemoChatResult.fromEngine(response);
  }

  Future<void> _sendMessage(
    String userMessage,
    List<String> connectionIds,
    bool fastMode,
    bool proMode,
    AgentMood agentMood,
  ) async {
    final trimmedMessage = userMessage.trim();
    if (trimmedMessage.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add(_chatMessage(
        role: ChatRole.USER,
        author: 'Demo User',
        content: trimmedMessage,
      ));
      _isLoading = true;
    });

    try {
      final result = await (widget.demoChatClient ?? _defaultDemoChatClient)(
        userMessage: trimmedMessage,
        sessionId: _sessionId,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _messages.add(_chatMessage(
          role: ChatRole.MODEL,
          author: 'Executive Orchestrator',
          content: result.chatOutput,
          output: result.agentTraceOutput,
        ));
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _messages.add(_chatMessage(
          role: ChatRole.MODEL,
          author: 'Executive Orchestrator',
          content:
              'The demo response could not be loaded. Make sure the Firebase '
              'functions emulator is running and try again.',
        ));
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  ChatMessage _chatMessage({
    required ChatRole role,
    required String author,
    required String content,
    String output = '',
  }) {
    return ChatMessage(
      id: _nextMessageId++,
      role: role,
      author: author,
      content: content,
      output: output,
      createdAt: Timestamp.fromDateTime(DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        foregroundColor: AppColors.primaryColor,
        title: const Text('Semur Demo'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              _DemoPromptCard(
                onRunSample: () => _sendMessage(
                  DemoChatScreen.samplePrompt,
                  const [],
                  false,
                  false,
                  AgentMood.NORMAL,
                ),
              ),
              Expanded(
                child: ChatComponent(
                  messages: _messages,
                  isLoading: _isLoading,
                  onSendMessage: _sendMessage,
                  needIntegrationSelected: false,
                  currentSessionId: _sessionId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoPromptCard extends StatelessWidget {
  final VoidCallback onRunSample;

  const _DemoPromptCard({
    required this.onRunSample,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.sparkles,
                color: AppColors.primaryColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Reproducible demo prompt',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SelectableText(
            DemoChatScreen.samplePrompt,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.darkColor,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: onRunSample,
              icon: const Icon(CupertinoIcons.play_fill, size: 16),
              label: const Text('Run sample demo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
