import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart';
import 'package:semur/models.pb/semur-engine/nango-engine/nango_engine.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine.pbenum.dart';
import 'package:semur/models.pb/semur-engine/syncs-engine/sync_engine_google-calendar.pb.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class SyncGoogleCalendarEngine {
  static String name = "sync_google_calendar";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
  }

  /// Generates an API token for the host user.
  static Future<SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper>
  events({
    required bool isDev,
    required SyncGoogleCalendarEventsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'events',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper(
          response: SyncGoogleCalendarEventsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper>
  eventsFromNangoToFirestore({
    required bool isDev,
    required SyncGoogleCalendarEventsFromNangoToFirestoreRequestWrapper
    requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'eventsFromNangoToFirestore',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper(
          response: SyncGoogleCalendarEventsFromNangoToFirestoreResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class SyncGoogleCalendarEmailsRequestWrapper {
  final SyncGoogleCalendarEventsRequest _request;

  SyncGoogleCalendarEmailsRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncGoogleCalendarEventsRequest(
         userId: userId,
         integrationId: integrationId,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

class SyncGoogleCalendarEventsFromNangoToFirestoreRequestWrapper {
  final SyncGoogleCalendarEventsFromNangoToFirestoreRequest _request;

  SyncGoogleCalendarEventsFromNangoToFirestoreRequestWrapper({
    required String userId,
    required String integrationId,
    Timestamp? modifiedAfter,
    int? limit,
    String? cursor,
    List<SyncFilter>? filters,
  }) : _request = SyncGoogleCalendarEventsFromNangoToFirestoreRequest(
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
class SyncGoogleCalendarEventsResponseWrapper {
  final NangoTriggerSyncResponse response;

  SyncGoogleCalendarEventsResponseWrapper({required this.response});

  factory SyncGoogleCalendarEventsResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncGoogleCalendarEventsResponseWrapper(
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

class SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper {
  final SyncGoogleCalendarEventsFromNangoToFirestoreResponse response;

  SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper({
    required this.response,
  });

  factory SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return SyncGoogleCalendarEventsFromNangoToFirestoreResponseWrapper(
      response: SyncGoogleCalendarEventsFromNangoToFirestoreResponse(
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
