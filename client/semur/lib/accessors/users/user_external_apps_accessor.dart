import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/external_apps/external_app.pbserver.dart';
import 'package:semur/transformers/users/external_app_firebase_transformer.dart';

enum UserExternalAppsAccessorQueryKey { ALL }

Map<UserExternalAppsAccessorQueryKey, List<String>>
userExternalAppsAccessorQueryArguments = {
  UserExternalAppsAccessorQueryKey.ALL: ["userId"],
};

class UserExternalAppsAccessor {
  static String firebaseCollectionName = "external_apps";

  final FirebaseFirestore firestore;
  UserExternalAppsAccessor({required this.firestore});

  Query buildQuery({
    required UserExternalAppsAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) {
    // Validate required arguments
    List<String> requiredArgs =
        userExternalAppsAccessorQueryArguments[queryKey] ?? [];
    for (String arg in requiredArgs) {
      if (!arguments.containsKey(arg)) {
        throw Exception("Missing required argument '$arg' for query $queryKey");
      }
    }

    // Build query based on key
    switch (queryKey) {
      case UserExternalAppsAccessorQueryKey.ALL:
        return firestore
            .collection(UserAccessor.firebaseCollectionName)
            .doc(arguments['userId'])
            .collection(firebaseCollectionName);
    }
  }

  Future<List<ExternalAppIntegration>> getQuery({
    required PermissionRoles callerRole,
    required UserExternalAppsAccessorQueryKey queryKey,
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
          .map((doc) => ExternalAppFirebaseTransformer.fromFirebase(doc))
          .toList();
    } catch (e) {
      throw Exception("Error fetching external apps: ${e.toString()}");
    }
  }

  Future<int> countQuery({
    required PermissionRoles callerRole,
    required UserExternalAppsAccessorQueryKey queryKey,
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
      throw Exception("Error fetching users: ${e.toString()}");
    }
  }

  Future<ExternalAppIntegration> get({
    required String userId,
    required String appId,
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
              .collection(UserAccessor.firebaseCollectionName)
              .doc(userId)
              .collection(firebaseCollectionName)
              .doc(appId)
              .get();

      if (!snapshot.exists) {
        throw Exception("External App not found.");
      }
      return ExternalAppFirebaseTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception("Error fetching external app: ${e.toString()}");
    }
  }

  Future<void> set({
    required ExternalAppIntegration app,
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
          .collection(UserAccessor.firebaseCollectionName)
          .doc(app.userId)
          .collection(firebaseCollectionName)
          .doc(app.id)
          .set(
            ExternalAppFirebaseTransformer.toJson(app),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw Exception("Error saving external app: ${e.toString()}");
    }
  }

  Future<void> delete({
    required String userId,
    required String appId,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [PermissionRoles.admin];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to delete this data.");
    }
    try {
      await firestore
          .collection(UserAccessor.firebaseCollectionName)
          .doc(userId)
          .collection(firebaseCollectionName)
          .doc(appId)
          .delete();
    } catch (e) {
      throw Exception("Error deleting external app: ${e.toString()}");
    }
  }

  Future<void> update({
    required ExternalAppIntegration app,
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
          .collection(UserAccessor.firebaseCollectionName)
          .doc(app.userId)
          .collection(firebaseCollectionName)
          .doc(app.id)
          .update(ExternalAppFirebaseTransformer.toJson(app));
    } catch (e) {
      throw Exception("Error updating external app: ${e.toString()}");
    }
  }

  Future<void> updateCustomFields({
    required String userId,
    required String appId,
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
          .collection(UserAccessor.firebaseCollectionName)
          .doc(userId)
          .collection(firebaseCollectionName)
          .doc(appId)
          .update(updatedData);
    } catch (e) {
      throw Exception("Error updating external app: ${e.toString()}");
    }
  }

  Future<bool> exists({
    required String userId,
    required String appId,
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
              .collection(UserAccessor.firebaseCollectionName)
              .doc(userId)
              .collection(firebaseCollectionName)
              .doc(appId)
              .get();

      return snapshot.exists;
    } catch (e) {
      throw Exception("Error checking external app existence: ${e.toString()}");
    }
  }
}
