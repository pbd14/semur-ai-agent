import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/external_apps/telegram_bot_integration.pbserver.dart';
import 'package:semur/transformers/external_apps/telegram_bot_integration_firebase_transformer.dart';

enum ExternalAppTelegramBotAccessorQueryKey { all }

Map<ExternalAppTelegramBotAccessorQueryKey, List<String>>
externalAppTelegramBotAccessorQueryArguments = {
  ExternalAppTelegramBotAccessorQueryKey.all: [],
};

class ExternalAppTelegramBotAccessor {
  static String firebaseCollectionName = "external_app_telegram_bot";

  final FirebaseFirestore firestore;
  ExternalAppTelegramBotAccessor({required this.firestore});

  Query buildQuery({
    required ExternalAppTelegramBotAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) {
    // Validate required arguments
    List<String> requiredArgs =
        externalAppTelegramBotAccessorQueryArguments[queryKey] ?? [];
    for (String arg in requiredArgs) {
      if (!arguments.containsKey(arg)) {
        throw Exception("Missing required argument '$arg' for query $queryKey");
      }
    }

    // Build query based on key
    switch (queryKey) {
      case ExternalAppTelegramBotAccessorQueryKey.all:
        return firestore.collection(firebaseCollectionName);
    }
  }

  Future<List<TelegramBotIntegration>> getQuery({
    required PermissionRoles callerRole,
    required ExternalAppTelegramBotAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
    int? limit,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
    ];

    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }

    try {
      Query query = buildQuery(queryKey: queryKey, arguments: arguments);
      if (limit != null) {
        query = query.limit(limit);
      }
      QuerySnapshot snapshot = await query.get();
      return snapshot.docs
          .map(
            (doc) =>
                TelegramBotIntegrationFirebaseTransformer.fromFirebase(doc),
          )
          .toList();
    } catch (e) {
      throw Exception(
        "Error fetching telegram bot integrations: ${e.toString()}",
      );
    }
  }

  Future<int> countQuery({
    required PermissionRoles callerRole,
    required ExternalAppTelegramBotAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
    ];

    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }

    try {
      AggregateQuerySnapshot snapshot =
          await buildQuery(
            queryKey: queryKey,
            arguments: arguments,
          ).count().get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception(
        "Error fetching telegram bot integrations: ${e.toString()}",
      );
    }
  }

  Future<TelegramBotIntegration> get({
    required String integrationId,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore
              .collection(firebaseCollectionName)
              .doc(integrationId)
              .get();

      if (!snapshot.exists) {
        throw Exception("External App not found.");
      }
      return TelegramBotIntegrationFirebaseTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception(
        "Error fetching telegram bot integration: ${e.toString()}",
      );
    }
  }

  Future<void> set({
    required TelegramBotIntegration integration,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.user,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to save this data.");
    }
    try {
      await firestore
          .collection(firebaseCollectionName)
          .doc(integration.id)
          .set(
            TelegramBotIntegrationFirebaseTransformer.toJson(integration),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw Exception("Error saving telegram bot integration: ${e.toString()}");
    }
  }

  Future<void> delete({
    required String integrationId,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [PermissionRoles.admin];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to delete this data.");
    }
    try {
      await firestore
          .collection(firebaseCollectionName)
          .doc(integrationId)
          .delete();
    } catch (e) {
      throw Exception(
        "Error deleting telegram bot integration: ${e.toString()}",
      );
    }
  }

  Future<void> update({
    required TelegramBotIntegration integration,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.user,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to update this data.");
    }
    try {
      await firestore
          .collection(firebaseCollectionName)
          .doc(integration.id)
          .update(
            TelegramBotIntegrationFirebaseTransformer.toJson(integration),
          );
    } catch (e) {
      throw Exception(
        "Error updating telegram bot integration: ${e.toString()}",
      );
    }
  }

  Future<void> updateCustomFields({
    required String integrationId,
    required Map<String, dynamic> updatedData,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.user,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to update this data.");
    }
    try {
      await firestore
          .collection(firebaseCollectionName)
          .doc(integrationId)
          .update(updatedData);
    } catch (e) {
      throw Exception(
        "Error updating telegram bot integration: ${e.toString()}",
      );
    }
  }

  Future<bool> exists({
    required String integrationId,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore
              .collection(firebaseCollectionName)
              .doc(integrationId)
              .get();

      return snapshot.exists;
    } catch (e) {
      throw Exception(
        "Error checking telegram bot integration existence: ${e.toString()}",
      );
    }
  }
}
