import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/modules/chat/widgets/chat_component.dart';
import 'package:semur/modules/chat/widgets/chat_message_widget.dart';
import 'package:semur/modules/demo/demo_chat_screen.dart';

void main() {
  testWidgets('renders agent collaboration trace for assistant message', (
    WidgetTester tester,
  ) async {
    const traceJson = '''
{
  "agentTrace": [
    {
      "agentId": "email_triage_agent",
      "displayName": "Email Triage Agent",
      "reason": "Search inbox context.",
      "status": "completed",
      "inputSummary": "Review selected email integrations.",
      "outputSummary": "Found two urgent email actions.",
      "evidenceIds": ["email-1"]
    },
    {
      "agentId": "calendar_planning_agent",
      "displayName": "Calendar Planning Agent",
      "reason": "Review calendar context.",
      "status": "skipped",
      "inputSummary": "Inspect calendar availability.",
      "outputSummary": "No active calendar connection was selected.",
      "evidenceIds": []
    }
  ]
}
''';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatMessageWidget(
            message: ChatMessage(
              id: 1,
              role: ChatRole.MODEL,
              author: 'Executive Orchestrator',
              content: 'Here is the executive summary.',
              output: traceJson,
            ),
            animateText: false,
          ),
        ),
      ),
    );

    expect(find.text('Agent Collaboration'), findsOneWidget);
    expect(find.text('Email Triage Agent'), findsOneWidget);
    expect(find.text('Calendar Planning Agent'), findsOneWidget);
    expect(find.text('Found two urgent email actions.'), findsOneWidget);
  });

  testWidgets('chat component can send without selected integrations', (
    WidgetTester tester,
  ) async {
    String? sentMessage;
    List<String>? sentConnectionIds;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 900,
            height: 700,
            child: ChatComponent(
              messages: const [],
              needIntegrationSelected: false,
              onSendMessage: (
                message,
                connectionIds,
                fastMode,
                proMode,
                agentMood,
              ) {
                sentMessage = message;
                sentConnectionIds = connectionIds;
                expect(agentMood, AgentMood.NORMAL);
              },
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Run the demo');
    await tester.tap(find.byIcon(CupertinoIcons.arrow_up));
    await tester.pump();

    expect(sentMessage, 'Run the demo');
    expect(sentConnectionIds, isEmpty);
  });

  testWidgets('demo screen renders deterministic collaboration trace', (
    WidgetTester tester,
  ) async {
    const traceJson = '''
{
  "agentTrace": [
    {
      "agentId": "email_triage_agent",
      "displayName": "Email Triage Agent",
      "reason": "Search demo inbox context.",
      "status": "completed",
      "inputSummary": "Review fixture inbox.",
      "outputSummary": "Found two urgent email actions.",
      "evidenceIds": ["demo-email-board-review"]
    },
    {
      "agentId": "calendar_planning_agent",
      "displayName": "Calendar Planning Agent",
      "reason": "Review demo calendar context.",
      "status": "completed",
      "inputSummary": "Inspect tomorrow.",
      "outputSummary": "Found one scheduling conflict.",
      "evidenceIds": ["demo-calendar-product-review"]
    },
    {
      "agentId": "drafting_agent",
      "displayName": "Drafting Agent",
      "reason": "Draft safe replies.",
      "status": "completed",
      "inputSummary": "Use specialist reports.",
      "outputSummary": "Prepared two review-only drafts.",
      "evidenceIds": ["demo-email-board-review"]
    }
  ]
}
''';

    await tester.pumpWidget(
      MaterialApp(
        home: DemoChatScreen(
          demoChatClient: ({required userMessage, required sessionId}) async {
            return const DemoChatResult(
              chatOutput: 'Demo response with drafts for review.',
              agentTraceOutput: traceJson,
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Run sample demo'));
    await tester.pumpAndSettle();

    expect(find.text('Agent Collaboration'), findsOneWidget);
    expect(find.text('Email Triage Agent'), findsOneWidget);
    expect(find.text('Calendar Planning Agent'), findsOneWidget);
    expect(find.text('Drafting Agent'), findsOneWidget);
  });
}
