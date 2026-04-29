import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart';
import 'package:semur/models.pb/semur-engine/nango-engine/nango_engine.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine_google-mail.pbserver.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class SyncGoogleMailEngine {
  static String name = "sync_google_mail";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
  }

  /// Generates an API token for the host user.
  static Future<SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper>
  emails({
    required bool isDev,
    required SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'emails',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper(
          response: SyncGoogleMailEmailsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper>
  emailsFromNangoToFirestore({
    required bool isDev,
    required SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'emails',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper(
          response: SyncGoogleMailEmailsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class SyncGoogleMailEmailsRequestWrapper {
  final SyncGoogleMailEmailsRequest _request;

  SyncGoogleMailEmailsRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncGoogleMailEmailsRequest(
         userId: userId,
         integrationId: integrationId,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

class SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper {
  final SyncGoogleMailEmailsFromNangoToFirestoreRequest _request;

  SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncGoogleMailEmailsFromNangoToFirestoreRequest(
         userId: userId,
         integrationId: integrationId,
         limit: limit,
         filter: filters,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

// Response Models
class SyncGoogleMailEmailsResponseWrapper {
  final NangoTriggerSyncResponse response;

  SyncGoogleMailEmailsResponseWrapper({required this.response});

  factory SyncGoogleMailEmailsResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncGoogleMailEmailsResponseWrapper(
      response: NangoTriggerSyncResponse(
        error: toSemurEngineErrorCode(
          json['error'] ?? SemurEngineErrorCode.CUSTOM_ERROR.value,
        ),
        message: json['message'] ?? "",
      ),
    );
  }

  bool validate() {
    if (!(response.hasError() && response.hasMessage())) {
      return false;
    }
    return true;
  }

  bool isSuccess() {
    if (!validate()) {
      return false;
    }
    if (response.error != SemurEngineErrorCode.NO_ERROR) {
      return false;
    }
    return true;
  }
}

class SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper {
  final SyncGoogleMailEmailsFromNangoToFirestoreResponse response;

  SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper({
    required this.response,
  });

  factory SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper(
      response: SyncGoogleMailEmailsFromNangoToFirestoreResponse(
        error: toSemurEngineErrorCode(
          json['error'] ?? SemurEngineErrorCode.CUSTOM_ERROR.value,
        ),
        message: json['message'] ?? "",
      ),
    );
  }

  bool validate() {
    if (!(response.hasError() && response.hasMessage())) {
      return false;
    }
    return true;
  }

  bool isSuccess() {
    if (!validate()) {
      return false;
    }
    if (response.error != SemurEngineErrorCode.NO_ERROR) {
      return false;
    }
    return true;
  }
}
