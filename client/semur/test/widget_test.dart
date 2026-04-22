import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/modules/chat/widgets/chat_message_widget.dart';

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
}
