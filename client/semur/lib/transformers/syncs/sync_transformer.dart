import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';

class SyncTransformer {
  static SyncInformation fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return SyncInformation(
        id: data["id"],
        nangoIntegrationId: data["nangoIntegrationId"],
        updatedAt:
            data["updatedAt"] != null
                ? firebaseToProtoTimestamp(data["updatedAt"])
                : null,
        nangoNextCursor: data["nangoNextCursor"],
        status: SyncStatus.valueOf(data["status"]),
        errorMessage: data["errorMessage"],
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to SyncInformation: ${e.toString()}",
      );
      return SyncInformation.create();
    }
  }

  static Map<String, dynamic> toJson(SyncInformation syncInfo) {
    return {
      "id":
          syncInfo.hasField(syncInfo.getTagNumber("id") ?? 0)
              ? syncInfo.id
              : null,
      "nangoIntegrationId":
          syncInfo.hasField(syncInfo.getTagNumber("nangoIntegrationId") ?? 0)
              ? syncInfo.nangoIntegrationId
              : null,
      "updatedAt":
          syncInfo.hasField(syncInfo.getTagNumber("updatedAt") ?? 0)
              ? protoToFirebaseTimestamp(syncInfo.updatedAt)
              : null,
      "nangoNextCursor":
          syncInfo.hasField(syncInfo.getTagNumber("nangoNextCursor") ?? 0)
              ? syncInfo.nangoNextCursor
              : null,
      "status":
          syncInfo.hasField(syncInfo.getTagNumber("status") ?? 0)
              ? syncInfo.status.value
              : null,
      "errorMessage":
          syncInfo.hasField(syncInfo.getTagNumber("errorMessage") ?? 0)
              ? syncInfo.errorMessage
              : null,
    };
  }
}
