import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/transformers/users/chat_firebase_transformer.dart';

enum UserChatAccessorQueryKey { ALL }

Map<UserChatAccessorQueryKey, List<String>> userChatAccessorQueryArguments = {
  UserChatAccessorQueryKey.ALL: ["userId"],
};

class UserChatAccessor {
  static String firebaseCollectionName = "chats";

  final FirebaseFirestore firestore;
  UserChatAccessor({required this.firestore});

  Query buildQuery({
    required UserChatAccessorQueryKey queryKey,
    Map<String, dynamic> arguments = const {},
  }) {
    // Validate required arguments
    List<String> requiredArgs = userChatAccessorQueryArguments[queryKey] ?? [];
    for (String arg in requiredArgs) {
      if (!arguments.containsKey(arg)) {
        throw Exception("Missing required argument '$arg' for query $queryKey");
      }
    }

    // Build query based on key
    switch (queryKey) {
      case UserChatAccessorQueryKey.ALL:
        return firestore
            .collection(UserAccessor.firebaseCollectionName)
            .doc(arguments['userId'])
            .collection(firebaseCollectionName);
    }
  }

  Future<List<ChatSession>> getQuery({
    required PermissionRoles callerRole,
    required UserChatAccessorQueryKey queryKey,
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
          .map((doc) => ChatFirebaseTransformer.fromFirebase(doc))
          .toList();
    } catch (e) {
      throw Exception("Error fetching chats: ${e.toString()}");
    }
  }

  Future<int> countQuery({
    required PermissionRoles callerRole,
    required UserChatAccessorQueryKey queryKey,
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

  Future<ChatSession> get({
    required String userId,
    required String chatId,
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
              .doc(chatId)
              .get();

      if (!snapshot.exists) {
        throw Exception("Chat not found.");
      }
      return ChatFirebaseTransformer.fromFirebase(snapshot);
    } catch (e) {
      throw Exception("Error fetching chat: ${e.toString()}");
    }
  }

  Future<void> set({
    required ChatSession chat,
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
          .doc(chat.userId)
          .collection(firebaseCollectionName)
          .doc(chat.id)
          .set(ChatFirebaseTransformer.toJson(chat), SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error saving chat: ${e.toString()}");
    }
  }

  Future<void> delete({
    required String userId,
    required String chatId,
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
          .doc(chatId)
          .delete();
    } catch (e) {
      throw Exception("Error deleting chat: ${e.toString()}");
    }
  }

  Future<void> update({
    required ChatSession chat,
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
          .doc(chat.userId)
          .collection(firebaseCollectionName)
          .doc(chat.id)
          .update(ChatFirebaseTransformer.toJson(chat));
    } catch (e) {
      throw Exception("Error updating chat: ${e.toString()}");
    }
  }

  Future<void> updateCustomFields({
    required String userId,
    required String chatId,
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
          .doc(chatId)
          .update(updatedData);
    } catch (e) {
      throw Exception("Error updating chat: ${e.toString()}");
    }
  }

  Future<bool> exists({
    required String userId,
    required String chatId,
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
              .doc(chatId)
              .get();

      return snapshot.exists;
    } catch (e) {
      throw Exception("Error checking chat existence: ${e.toString()}");
    }
  }
}
