import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/timestamp_converter.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pbserver.dart';

class TelegramBotIntegrationFirebaseTransformer {
  static TelegramBotIntegration fromFirebase(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;
      return TelegramBotIntegration(
        id: snapshot.id,
        username: data["username"],
        userId: data["userId"],
        userFirstName: data["userFirstName"],
        userLastName: data["userLastName"],
        integrationStatus: TelegramBotIntegrationStatus.valueOf(
          data["integrationStatus"],
        ),
        createdAt:
            data["createdAt"] != null
                ? firebaseToProtoTimestamp(data["createdAt"])
                : null,
      );
    } catch (e) {
      Log.w(
        "Error transforming Firebase document to ExternalAppIntegration: ${e.toString()}",
      );
      return TelegramBotIntegration.create();
    }
  }

  static Map<String, dynamic> toJson(TelegramBotIntegration integration) {
    return {
      "id":
          integration.hasField(integration.getTagNumber("id") ?? 0)
              ? integration.id
              : null,
      "username":
          integration.hasField(integration.getTagNumber("username") ?? 0)
              ? integration.username
              : null,
      "userId":
          integration.hasField(integration.getTagNumber("userId") ?? 0)
              ? integration.userId
              : null,
      "userFirstName":
          integration.hasField(integration.getTagNumber("userFirstName") ?? 0)
              ? integration.userFirstName
              : null,
      "userLastName":
          integration.hasField(integration.getTagNumber("userLastName") ?? 0)
              ? integration.userLastName
              : null,
      "integrationStatus":
          integration.hasField(
                integration.getTagNumber("integrationStatus") ?? 0,
              )
              ? integration.integrationStatus.value
              : null,
      "createdAt":
          integration.hasField(integration.getTagNumber("createdAt") ?? 0)
              ? protoToFirebaseTimestamp(integration.createdAt)
              : null,
    };
  }
}
