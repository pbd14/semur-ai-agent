import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart';
import 'package:semur/models.pb/semur-engine/nango-engine/nango_engine.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine_outlook-mail.pb.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class SyncOutlookMailEngine {
  static String name = "sync_outlook_mail";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
  }

  /// Generates an API token for the host user.
  static Future<SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper>
  emails({
    required bool isDev,
    required SyncOutlookMailEmailsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'emails',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper(
          response: SyncOutlookMailEmailsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper>
  emailsFromNangoToFirestore({
    required bool isDev,
    required SyncOutlookMailEmailsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'emails',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper(
          response: SyncOutlookMailEmailsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class SyncOutlookMailEmailsRequestWrapper {
  final SyncOutlookMailEmailsRequest _request;

  SyncOutlookMailEmailsRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncOutlookMailEmailsRequest(
         userId: userId,
         integrationId: integrationId,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

class SyncOutlookMailEmailsFromNangoToFirestoreRequestWrapper {
  final SyncOutlookMailEmailsFromNangoToFirestoreRequest _request;

  SyncOutlookMailEmailsFromNangoToFirestoreRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncOutlookMailEmailsFromNangoToFirestoreRequest(
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
class SyncOutlookMailEmailsResponseWrapper {
  final NangoTriggerSyncResponse response;

  SyncOutlookMailEmailsResponseWrapper({required this.response});

  factory SyncOutlookMailEmailsResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncOutlookMailEmailsResponseWrapper(
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

class SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper {
  final SyncOutlookMailEmailsFromNangoToFirestoreResponse response;

  SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper({
    required this.response,
  });

  factory SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncOutlookMailEmailsFromNangoToFirestoreResponseWrapper(
      response: SyncOutlookMailEmailsFromNangoToFirestoreResponse(
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
