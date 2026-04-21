import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';

class ChatFirebaseTransformer {
  static ChatSession fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return ChatSession(
        id: snapshot.id,
        userId: data["userId"],
        agentCategory: AgentCategory.valueOf(data["agentCategory"]),
        currentMessageIndex: data["currentMessageIndex"],
        createdAt:
            data["createdAt"] != null
                ? firebaseToProtoTimestamp(data["createdAt"])
                : null,
        title: data["title"],
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to ChatSession: ${e.toString()}",
      );
      return ChatSession.create();
    }
  }

  static Map<String, dynamic> toJson(ChatSession user) {
    return {
      "id": user.hasField(user.getTagNumber("id") ?? 0) ? user.id : null,
      "userId":
          user.hasField(user.getTagNumber("userId") ?? 0) ? user.userId : null,
      "agentCategory":
          user.hasField(user.getTagNumber("agentCategory") ?? 0)
              ? user.agentCategory.value
              : null,
      "currentMessageIndex":
          user.hasField(user.getTagNumber("currentMessageIndex") ?? 0)
              ? user.currentMessageIndex
              : null,
      "createdAt":
          user.hasField(user.getTagNumber("createdAt") ?? 0)
              ? protoToFirebaseTimestamp(user.createdAt)
              : null,
      "title":
          user.hasField(user.getTagNumber("title") ?? 0) ? user.title : null,
    };
  }
}
