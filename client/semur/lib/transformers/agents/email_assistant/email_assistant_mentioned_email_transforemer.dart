import 'package:semur/models.pb/agents/email_assistant.pb.dart';

class EmailAssistantMentionedEmailTransforemer {
  static EmailAssistantMentionedEmail fromMap(Map<String, dynamic> map) {
    return EmailAssistantMentionedEmail(
      id: map['id'] ?? '',
      nangoIntegrationId: map['nangoIntegrationId'] ?? '',
      provider: map['provider'] ?? '',
      subject: map['subject'] ?? '',
      senderName: map['senderName'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      snippet: map['snippet'] ?? '',
      date: map['date'] ?? '',
      importanceScore:
          (map['importanceScore'] != null)
              ? (map['importanceScore'] as num).toDouble()
              : 0.0,
    );
  }
}
