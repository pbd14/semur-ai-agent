import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/user/user.pb.dart';

class UserFirebaseTransformer {
  static SemurUser fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return SemurUser(
        id: snapshot.id,
        email: data["email"],
        firstName: data["firstName"],
        lastName: data["lastName"],
        birthDate:
            data["birthDate"] != null
                ? firebaseToProtoTimestamp(data["birthDate"])
                : null,
        status: UserStatus.valueOf(data["status"]),
        fcmAndroidTokens: List<String>.from(data["fcmAndroidTokens"] ?? []),
        fcmIosTokens: List<String>.from(data["fcmIosTokens"] ?? []),
        vapidWebTokens: List<String>.from(data["vapidWebTokens"] ?? []),
        language: data["language"],
        organizationId: data["organizationId"],
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to SemurUser: ${e.toString()}",
      );
      return SemurUser.create();
    }
  }

  static Map<String, dynamic> toJson(SemurUser user) {
    return {
      "id": user.hasField(user.getTagNumber("id") ?? 0) ? user.id : null,
      "email":
          user.hasField(user.getTagNumber("email") ?? 0) ? user.email : null,
      "firstName":
          user.hasField(user.getTagNumber("firstName") ?? 0)
              ? user.firstName
              : null,
      "lastName":
          user.hasField(user.getTagNumber("lastName") ?? 0)
              ? user.lastName
              : null,
      "birthDate":
          user.hasField(user.getTagNumber("birthDate") ?? 0)
              ? protoToFirebaseTimestamp(user.birthDate)
              : null,
      "status":
          user.hasField(user.getTagNumber("status") ?? 0)
              ? user.status.value
              : null,
      "fcmAndroidTokens":
          user.hasField(user.getTagNumber("fcmAndroidTokens") ?? 0)
              ? user.fcmAndroidTokens
              : null,
      "fcmIosTokens":
          user.hasField(user.getTagNumber("fcmIosTokens") ?? 0)
              ? user.fcmIosTokens
              : null,
      "vapidWebTokens":
          user.hasField(user.getTagNumber("vapidWebTokens") ?? 0)
              ? user.vapidWebTokens
              : null,
      "language":
          user.hasField(user.getTagNumber("language") ?? 0)
              ? user.language
              : null,
      "organizationId":
          user.hasField(user.getTagNumber("organizationId") ?? 0)
              ? user.organizationId
              : null,
    };
  }
}
