import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pb.dart';

class SyncGoogleMailEmailTransformer {
  static SyncGoogleMailEmail fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return SyncGoogleMailEmail(
        id: data["id"],
        sender: data["sender"],
        recipients: data["recipients"],
        date:
            data["date"] != null
                ? firebaseToProtoTimestamp(data["date"])
                : null,
        subject: data["subject"],
        body: data["body"],
        attachments:
            data["attachments"] != null
                ? List<SyncGoogleMailEmailAttachment>.from(
                  data["attachments"].map(
                    (attachment) => SyncGoogleMailEmailAttachment(
                      filename: attachment["filename"],
                      mimeType: attachment["mimeType"],
                      size: attachment["size"],
                      attachmentId: attachment["attachmentId"],
                    ),
                  ),
                )
                : [],
        threadId: data["threadId"],
        nangoMetadata:
            data["nangoMetadata"] != null
                ? SyncNangoMetadata(
                  deletedAt:
                      data["nangoMetadata"]["deletedAt"] != null
                          ? firebaseToProtoTimestamp(
                            data["nangoMetadata"]["deletedAt"],
                          )
                          : null,
                  lastAction: data["nangoMetadata"]["lastAction"],
                  firstSeenAt: firebaseToProtoTimestamp(
                    data["nangoMetadata"]["firstSeenAt"],
                  ),
                  cursor: data["nangoMetadata"]["cursor"],
                  lastModifiedAt: firebaseToProtoTimestamp(
                    data["nangoMetadata"]["lastModifiedAt"],
                  ),
                )
                : null,
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to SyncGoogleMailEmail: ${e.toString()}",
      );
      return SyncGoogleMailEmail.create();
    }
  }

  static Map<String, dynamic> toJson(SyncGoogleMailEmail email) {
    return {
      "id": email.hasField(email.getTagNumber("id") ?? 0) ? email.id : null,
      "sender":
          email.hasField(email.getTagNumber("sender") ?? 0)
              ? email.sender
              : null,
      "recipients":
          email.hasField(email.getTagNumber("recipients") ?? 0)
              ? email.recipients
              : null,
      "date":
          email.hasField(email.getTagNumber("date") ?? 0)
              ? protoToFirebaseTimestamp(email.date)
              : null,
      "subject":
          email.hasField(email.getTagNumber("subject") ?? 0)
              ? email.subject
              : null,
      "body":
          email.hasField(email.getTagNumber("body") ?? 0) ? email.body : null,
      "attachments":
          email.hasField(email.getTagNumber("attachments") ?? 0)
              ? email.attachments
              : null,
      "threadId":
          email.hasField(email.getTagNumber("threadId") ?? 0)
              ? email.threadId
              : null,
      "nangoMetadata":
          email.hasField(email.getTagNumber("nangoMetadata") ?? 0)
              ? email.nangoMetadata
              : null,
    };
  }
}
