import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/models.pb/nango/nango.pb.dart';

class NangoIntegrationFirebaseTransformer {
  static NangoIntegration fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return NangoIntegration(
        id: snapshot.id,
        name: data["name"],
        status: NangoIntegrationStatus.valueOf(data["status"]),
        categories: List<AgentCategory>.from(
          (data["categories"] ?? []).map(
            (category) => AgentCategory.valueOf(category),
          ),
        ),
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to NangoIntegration: ${e.toString()}",
      );
      return NangoIntegration.create();
    }
  }

  static Map<String, dynamic> toJson(NangoIntegration user) {
    return {
      "id": user.hasField(user.getTagNumber("id") ?? 0) ? user.id : null,
      "name": user.hasField(user.getTagNumber("name") ?? 0) ? user.name : null,
      "status":
          user.hasField(user.getTagNumber("status") ?? 0)
              ? user.status.value
              : null,
      "categories":
          user.hasField(user.getTagNumber("categories") ?? 0)
              ? user.categories.map((category) => category.value).toList()
              : null,
    };
  }
}
