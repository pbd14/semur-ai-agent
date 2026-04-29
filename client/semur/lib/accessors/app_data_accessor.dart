import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:semur/transformers/nango_integration_firebase_transformer.dart';

enum AppDataAccessorQueryKey { getAll }

class AppDataAccessor {
  static String firebaseCollectionName = "app_data";
  static String firebaseSemurVarsDocumentId = "semur_vars";
  static String firebaseNangoDocumentId = "nango";
  static String firebaseNangoAvailableIntegrationsCollectionName =
      "available_integrations";

  final FirebaseFirestore firestore;
  final Map<AppDataAccessorQueryKey, Query> queries = {};
  AppDataAccessor({required this.firestore}) {
    queries[AppDataAccessorQueryKey.getAll] = firestore.collection(
      firebaseCollectionName,
    );
  }

  Future<SemurVarsModel> get({required PermissionRoles callerRole}) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
      PermissionRoles.guest,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore
              .collection(firebaseCollectionName)
              .doc(firebaseSemurVarsDocumentId)
              .get();

      if (!snapshot.exists) {
        throw Exception("Semur vars not found.");
      }
      return SemurVarsModel.fromSnapshot(snapshot);
    } catch (e) {
      throw Exception("Error fetching semur vars: ${e.toString()}");
    }
  }

  // Nango
  Future<List<NangoIntegration>> getNangoIntegrations({
    required PermissionRoles callerRole,
  }) async {
    List<PermissionRoles> allowedRoles = [
      PermissionRoles.admin,
      PermissionRoles.hostUser,
      PermissionRoles.businessUser,
      PermissionRoles.user,
      PermissionRoles.guest,
    ];
    if (!allowedRoles.contains(callerRole)) {
      throw Exception("You do not have permission to access this data.");
    }

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore
              .collection(firebaseCollectionName)
              .doc(firebaseNangoDocumentId)
              .collection(firebaseNangoAvailableIntegrationsCollectionName)
              .get();

      return snapshot.docs
          .map((doc) => NangoIntegrationFirebaseTransformer.fromFirebase(doc))
          .toList();
    } catch (e) {
      throw Exception("Error fetching Nango integrations: ${e.toString()}");
    }
  }
}

class SemurVarsModel {
  final bool isWebActive;
  final bool emailVerificationRequired;
  final String privacyPolicyLink;
  final int privacyPolicyVersion;

  SemurVarsModel({
    required this.isWebActive,
    required this.emailVerificationRequired,
    required this.privacyPolicyLink,
    required this.privacyPolicyVersion,
  });

  factory SemurVarsModel.fromJson(Map<String, dynamic> json) {
    return SemurVarsModel(
      isWebActive: json['isWebActive'] ?? false,
      emailVerificationRequired: json['emailVerificationRequired'] ?? false,
      privacyPolicyLink: json['privacyPolicyLink'] ?? '',
      privacyPolicyVersion: json['privacyPolicyVersion'] ?? 0,
    );
  }

  // From Snapshot
  factory SemurVarsModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (!snapshot.exists) {
      throw Exception("Snapshot does not exist");
    }
    final data = snapshot.data() as Map<String, dynamic>;
    return SemurVarsModel.fromJson(data);
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'isWebActive': isWebActive,
      'emailVerificationRequired': emailVerificationRequired,
      'privacyPolicyLink': privacyPolicyLink,
      'privacyPolicyVersion': privacyPolicyVersion,
    };
  }
}
