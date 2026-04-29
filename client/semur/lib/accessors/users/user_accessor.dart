import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/user/user.pb.dart';
import 'package:semur/transformers/users/user_firebase_transformer.dart';

enum UserAccessorQueryKey { getAll, countByEmail }

Map<UserAccessorQueryKey, List<String>> userAccessorQueryArguments = {
  UserAccessorQueryKey.getAll: [],
  UserAccessorQueryKey.countByEmail: ['email'],
};

class UserAccessor {
  static String firebaseCollectionName = "users";

  final FirebaseFirestore firestore;
  UserAccessor({required this.firestore});

  Query buildQuery({
    required UserAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) {
    // Validate required arguments
    List<String> requiredArgs = userAccessorQueryArguments[queryKey] ?? [];
    for (String arg in requiredArgs) {
      if (!arguments.containsKey(arg)) {
        throw Exception("Missing required argument '$arg' for query $queryKey");
      }
    }

    // Build query based on key
    switch (queryKey) {
      case UserAccessorQueryKey.getAll:
        return firestore.collection(firebaseCollectionName);

      case UserAccessorQueryKey.countByEmail:
        return firestore
            .collection(firebaseCollectionName)
            .where('email', isEqualTo: arguments['email']);
    }
  }

  Future<List<SemurUser>> getQuery({
    required PermissionRoles callerRole,
    required UserAccessorQueryKey queryKey,
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
      QuerySnapshot snapshot =
          await buildQuery(queryKey: queryKey, arguments: arguments).get();
      return snapshot.docs
          .map((doc) => UserFirebaseTransformer.fromFirebase(doc))
          .toList();
    } catch (e) {
      throw Exception("Error fetching users: ${e.toString()}");
    }
  }

  Future<int> countQuery({
    required PermissionRoles callerRole,
    required UserAccessorQueryKey queryKey,
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

  Future<SemurUser> get({
    required String userId,
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
          await firestore.collection(firebaseCollectionName).doc(userId).get();

      if (!snapshot.exists) {
        throw Exception("User not found.");
      }
      return UserFirebaseTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception("Error fetching user: ${e.toString()}");
    }
  }

  Future<void> set({
    required SemurUser user,
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
          .doc(user.id)
          .set(UserFirebaseTransformer.toJson(user), SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error saving user: ${e.toString()}");
    }
  }

  Future<void> delete({
    required String userId,
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [PermissionRoles.admin];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to delete this data.");
    }
    try {
      await firestore.collection(firebaseCollectionName).doc(userId).delete();
    } catch (e) {
      throw Exception("Error deleting user: ${e.toString()}");
    }
  }

  Future<void> update({
    required SemurUser user,
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
          .doc(user.id)
          .update(UserFirebaseTransformer.toJson(user));
    } catch (e) {
      throw Exception("Error updating user: ${e.toString()}");
    }
  }

  Future<void> updateCustomFields({
    required String userId,
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
          .doc(userId)
          .update(updatedData);
    } catch (e) {
      throw Exception("Error updating user: ${e.toString()}");
    }
  }

  Future<bool> exists({
    required String userId,
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
          await firestore.collection(firebaseCollectionName).doc(userId).get();

      return snapshot.exists;
    } catch (e) {
      throw Exception("Error checking user existence: ${e.toString()}");
    }
  }
}
