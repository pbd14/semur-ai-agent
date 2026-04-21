import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/external_apps/external_app.pb.dart';

class ExternalAppFirebaseTransformer {
  static ExternalAppIntegration fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return ExternalAppIntegration(
        id: snapshot.id,
        userId: data["userId"],
        type: ExternalAppType.valueOf(data["type"]),
        metadata: data["metadata"] != null 
            ? Map<String, String>.from(data["metadata"]) 
            : null,
        status: ExternalAppIntegrationStatus.valueOf(data["status"]),
        createdAt:
            data["createdAt"] != null
                ? firebaseToProtoTimestamp(data["createdAt"])
                : null,
        updatedAt:
            data["updatedAt"] != null
                ? firebaseToProtoTimestamp(data["updatedAt"])
                : null,
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to ExternalAppIntegration: ${e.toString()}",
      );
      return ExternalAppIntegration.create();
    }
  }

  static Map<String, dynamic> toJson(ExternalAppIntegration app) {
    return {
      "id": app.hasField(app.getTagNumber("id") ?? 0) ? app.id : null,
      "userId":
          app.hasField(app.getTagNumber("userId") ?? 0) ? app.userId : null,
      "type":
          app.hasField(app.getTagNumber("type") ?? 0) ? app.type.value : null,
      "metadata":
          app.hasField(app.getTagNumber("metadata") ?? 0) ? app.metadata : null,
      "status":
          app.hasField(app.getTagNumber("status") ?? 0)
              ? app.status.value
              : null,
      "createdAt":
          app.hasField(app.getTagNumber("createdAt") ?? 0)
              ? protoToFirebaseTimestamp(app.createdAt)
              : null,
      "updatedAt":
          app.hasField(app.getTagNumber("updatedAt") ?? 0)
              ? protoToFirebaseTimestamp(app.updatedAt)
              : null,
    };
  }
}
