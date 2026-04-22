import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/agents/email_assistant.pbserver.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/transformers/agents/email_assistant/email_assistant_mentioned_email_transforemer.dart';

class ChatMessageFirebaseTransformer {
  static ChatMessage fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return ChatMessage(
        id: data["id"] ?? int.parse(snapshot.id),
        role: ChatRole.valueOf(data["role"]),
        author: data["author"],
        content: data["content"],
        followUpQuestions: List<String>.from(data["followUpQuestions"] ?? []),
        output: data["output"] ?? '',
        toolName: data["toolName"] ?? '',
        toolRequestJson: data["toolRequestJson"] ?? '',
        toolResponseJson: data["toolResponseJson"] ?? '',
        metadata:
            data["metadata"] != null
                ? ChatMetadata(
                  emailAssistant:
                      data["metadata"]?["emailAssistant"] != null
                          ? EmailAssistantChatMetadata(
                            totalEmailsAnalyzed:
                                data["metadata"]?["emailAssistant"]?["totalEmailsAnalyzed"] ??
                                0,
                            timeRange:
                                data["metadata"]?["emailAssistant"]?["timeRange"] ??
                                "",
                          )
                          : null,
                )
                : null,
        artifacts:
            data["artifacts"] != null
                ? ChatArtifacts(
                  emailAssistant:
                      data["artifacts"]?["emailAssistant"] != null
                          ? EmailAssistantChatArtifacts(
                            // Convert each element of data["artifacts"]?["emailAssistant"]?["mentionedEmails"] to MentionedEmail and then group to list<MentionedEmail>
                            mentionedEmails:
                                (data["artifacts"]?["emailAssistant"]?["mentionedEmails"]
                                            as List<dynamic>? ??
                                        [])
                                    .map(
                                      (e) =>
                                          EmailAssistantMentionedEmailTransforemer.fromMap(
                                            e as Map<String, dynamic>,
                                          ),
                                    )
                                    .toList(),
                          )
                          : null,
                )
                : null,
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to ChatMessage: ${e.toString()}",
      );
      return ChatMessage.create();
    }
  }

  static Map<String, dynamic> toJson(ChatMessage message) {
    return {
      "id":
          message.hasField(message.getTagNumber("id") ?? 0) ? message.id : null,
      "role":
          message.hasField(message.getTagNumber("role") ?? 0)
              ? message.role.value
              : null,
      "author":
          message.hasField(message.getTagNumber("author") ?? 0)
              ? message.author
              : null,
      "content":
          message.hasField(message.getTagNumber("content") ?? 0)
              ? message.content
              : null,
      "followUpQuestions":
          message.hasField(message.getTagNumber("followUpQuestions") ?? 0)
              ? message.followUpQuestions
              : null,
      "metadata":
          message.hasField(message.getTagNumber("metadata") ?? 0)
              ? message.metadata
              : null,
      "artifacts":
          message.hasField(message.getTagNumber("artifacts") ?? 0)
              ? message.artifacts
              : null,
      "output":
          message.hasField(message.getTagNumber("output") ?? 0)
              ? message.output
              : null,
      "toolName":
          message.hasField(message.getTagNumber("toolName") ?? 0)
              ? message.toolName
              : null,
      "toolRequestJson":
          message.hasField(message.getTagNumber("toolRequestJson") ?? 0)
              ? message.toolRequestJson
              : null,
      "toolResponseJson":
          message.hasField(message.getTagNumber("toolResponseJson") ?? 0)
              ? message.toolResponseJson
              : null,
    };
  }
}
