import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pbserver.dart';
import 'package:semur/transformers/syncs/sync_google_mail_email_transformer.dart';
import 'package:semur/transformers/syncs/sync_transformer.dart';

enum UserSyncGoogleMailAccessorQueryKey { ALL, LATEST_WITH_LAST_DOCUMENT }

Map<UserSyncGoogleMailAccessorQueryKey, List<String>>
userSyncGoogleMailAccessorQueryArguments = {
  UserSyncGoogleMailAccessorQueryKey.ALL: ["userId", "nangoIntegrationId"],
  UserSyncGoogleMailAccessorQueryKey.LATEST_WITH_LAST_DOCUMENT: [
    "userId",
    "nangoIntegrationId",
    "lastDocument",
  ],
};

class UserSyncGoogleMailAccessor {
  static String firebaseCollectionName = "syncs";
  static String firestoreNangoConnectionsSubcollectionName =
      "nango_connections";
  static String firestoreSyncDocumentId = "sync";

  final FirebaseFirestore firestore;
  UserSyncGoogleMailAccessor({required this.firestore});

  Query buildQuery({
    required UserSyncGoogleMailAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) {
    // Validate required arguments
    List<String> requiredArgs =
        userSyncGoogleMailAccessorQueryArguments[queryKey] ?? [];
    for (String arg in requiredArgs) {
      if (!arguments.containsKey(arg)) {
        throw Exception("Missing required argument '$arg' for query $queryKey");
      }
    }

    // Build query based on key
    switch (queryKey) {
      case UserSyncGoogleMailAccessorQueryKey.ALL:
        return firestore
            .collection(UserAccessor.firebaseCollectionName)
            .doc(arguments['userId'])
            .collection(firestoreNangoConnectionsSubcollectionName)
            .doc(arguments['nangoIntegrationId'])
            .collection(firebaseCollectionName)
            .where("id", isNotEqualTo: firestoreSyncDocumentId);
      case UserSyncGoogleMailAccessorQueryKey.LATEST_WITH_LAST_DOCUMENT:
        Query query = firestore
            .collection(UserAccessor.firebaseCollectionName)
            .doc(arguments['userId'])
            .collection(firestoreNangoConnectionsSubcollectionName)
            .doc(arguments['nangoIntegrationId'])
            .collection(firebaseCollectionName)
            .orderBy("date", descending: true);
        if (arguments['lastDocument'] != null &&
            arguments['lastDocument'] is DocumentSnapshot) {
          query = query.startAfterDocument(arguments['lastDocument']);
        }
        query = query.limit(50);
        return query;
    }
  }

  Future<List<SyncGoogleMailEmail>> getQuery({
    required PermissionRoles callerRole,
    required UserSyncGoogleMailAccessorQueryKey queryKey,
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
          .where((doc) => doc.id != firestoreSyncDocumentId)
          .map((doc) => SyncGoogleMailEmailTransformer.fromFirebase(doc))
          .toList();
    } catch (e) {
      throw Exception("Error fetching syncs: ${e.toString()}");
    }
  }

  Future<(List<SyncGoogleMailEmail>, DocumentSnapshot?)>
  getQueryWithLastDocumentSnapshot({
    required PermissionRoles callerRole,
    required UserSyncGoogleMailAccessorQueryKey queryKey,
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
      return (
        snapshot.docs
            .map((doc) => SyncGoogleMailEmailTransformer.fromFirebase(doc))
            .toList(),
        snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
      );
    } catch (e) {
      throw Exception("Error fetching syncs: ${e.toString()}");
    }
  }

  Future<int> countQuery({
    required PermissionRoles callerRole,
    required UserSyncGoogleMailAccessorQueryKey queryKey,
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
      throw Exception("Error fetching syncs: ${e.toString()}");
    }
  }

  Future<SyncGoogleMailEmail> get({
    required String userId,
    required String nangoIntegrationId,
    required String syncId,
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
              .collection(firestoreNangoConnectionsSubcollectionName)
              .doc(nangoIntegrationId)
              .collection(firebaseCollectionName)
              .doc(syncId)
              .get();

      if (!snapshot.exists) {
        throw Exception("Sync email not found.");
      }
      return SyncGoogleMailEmailTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception("Error fetching sync email: ${e.toString()}");
    }
  }

  Future<void> set({
    required String userId,
    required String nangoIntegrationId,
    required SyncGoogleMailEmail syncEmail,
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
          .doc(userId)
          .collection(firestoreNangoConnectionsSubcollectionName)
          .doc(nangoIntegrationId)
          .collection(firebaseCollectionName)
          .doc(syncEmail.id)
          .set(
            SyncGoogleMailEmailTransformer.toJson(syncEmail),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw Exception("Error saving sync email: ${e.toString()}");
    }
  }

  Future<void> delete({
    required String userId,
    required String nangoIntegrationId,
    required String syncId,
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
          .collection(firestoreNangoConnectionsSubcollectionName)
          .doc(nangoIntegrationId)
          .collection(firebaseCollectionName)
          .doc(syncId)
          .delete();
    } catch (e) {
      throw Exception("Error deleting sync email: ${e.toString()}");
    }
  }

  Future<void> update({
    required String userId,
    required String nangoIntegrationId,
    required SyncGoogleMailEmail syncEmail,
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
          .collection(firestoreNangoConnectionsSubcollectionName)
          .doc(nangoIntegrationId)
          .collection(firebaseCollectionName)
          .doc(syncEmail.id)
          .update(SyncGoogleMailEmailTransformer.toJson(syncEmail));
    } catch (e) {
      throw Exception("Error updating sync email: ${e.toString()}");
    }
  }

  Future<void> updateCustomFields({
    required String userId,
    required String nangoIntegrationId,
    required String syncId,
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
          .doc(nangoIntegrationId)
          .collection(firebaseCollectionName)
          .doc(syncId)
          .update(updatedData);
    } catch (e) {
      throw Exception("Error updating sync email: ${e.toString()}");
    }
  }

  Future<bool> exists({
    required String userId,
    required String nangoIntegrationId,
    required String syncId,
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
              .collection(firestoreNangoConnectionsSubcollectionName)
              .doc(nangoIntegrationId)
              .collection(firebaseCollectionName)
              .doc(syncId)
              .get();

      return snapshot.exists;
    } catch (e) {
      throw Exception("Error checking sync email existence: ${e.toString()}");
    }
  }

  // Sync information
  Future<SyncInformation> getSyncInfo({
    required String userId,
    required String nangoIntegrationId,
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
              .collection(firestoreNangoConnectionsSubcollectionName)
              .doc(nangoIntegrationId)
              .collection(firebaseCollectionName)
              .doc("sync")
              .get();

      if (!snapshot.exists) {
        throw Exception("Sync info not found.");
      }
      return SyncTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception("Error fetching sync info: ${e.toString()}");
    }
  }
}
