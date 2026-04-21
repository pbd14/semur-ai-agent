import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:semur/models.pb/semur-engine/nango-engine/nango_engine.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class NangoEngine {
  static String name = "nango";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
  }

  /// Generates an API token for the host user.
  static Future<NangoSessionTokenResponseWrapper> sessionToken({
    required bool isDev,
    required NangoSessionTokenRequestWrapper requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'sessionToken',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return NangoSessionTokenResponseWrapper(
          response: NangoSessionTokenResponse(
            token: null,
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return NangoSessionTokenResponseWrapper.fromJsonMap(result.data);
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<NangoUserConnectionsResponseWrapper> userConnections({
    required bool isDev,
    required NangoUserConnectionsRequestWrapper requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'userConnections',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return NangoUserConnectionsResponseWrapper(
          response: NangoUserConnectionsResponse(
            connections: [],
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return NangoUserConnectionsResponseWrapper.fromJsonMap(result.data);
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class NangoSessionTokenRequestWrapper {
  final NangoSessionTokenRequest _request;

  NangoSessionTokenRequestWrapper({
    required String integrationId,
    required String userId,
    required String userEmail,
    required String userName,
  }) : _request = NangoSessionTokenRequest(
         integrationId: integrationId,
         userId: userId,
         userEmail: userEmail,
         userName: userName,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

class NangoUserConnectionsRequestWrapper {
  final NangoUserConnectionsRequest _request;

  NangoUserConnectionsRequestWrapper({required String userId})
    : _request = NangoUserConnectionsRequest(userId: userId);

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

// Response Models
class NangoSessionTokenResponseWrapper {
  final NangoSessionTokenResponse response;

  NangoSessionTokenResponseWrapper({required this.response});

  static bool validateJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return false;
    }
    if (json['token'] == null) {
      return false;
    }
    try {
      NangoSessionTokenResponse.create().mergeFromProto3Json(json);
    } catch (e) {
      return false;
    }
    return true;
  }

  factory NangoSessionTokenResponseWrapper.fromJsonMap(
    Map<String, dynamic> json,
  ) {
    if (!validateJson(json)) {
      return NangoSessionTokenResponseWrapper(
        response: NangoSessionTokenResponse(
          token: "",
          error: SemurEngineErrorCode.INTERNAL_ERROR,
          message: "Invalid data received from the server",
        ),
      );
    }
    return NangoSessionTokenResponseWrapper(
      response: NangoSessionTokenResponse(
        token: json['token'] ?? "",
        error: toSemurEngineErrorCode(
          json['error'] ?? SemurEngineErrorCode.CUSTOM_ERROR.value,
        ),
        message: json['message'] ?? "",
      ),
    );
  }

  bool validate() {
    if (!(response.hasToken() &&
        response.hasError() &&
        response.hasMessage())) {
      return false;
    }
    if (response.token.isEmpty) {
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

  Map<String, dynamic> toJsonMap() {
    return response.toProto3Json() as Map<String, dynamic>;
  }
}

class NangoUserConnectionsResponseWrapper {
  final NangoUserConnectionsResponse response;

  NangoUserConnectionsResponseWrapper({required this.response});

  static bool validateJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return false;
    }
    if (json['connections'] == null) {
      return false;
    }
    try {
      NangoUserConnectionsResponse.create().mergeFromProto3Json(json);
    } catch (e) {
      return false;
    }
    return true;
  }

  factory NangoUserConnectionsResponseWrapper.fromJsonMap(
    Map<String, dynamic> json,
  ) {
    if (!validateJson(json)) {
      return NangoUserConnectionsResponseWrapper(
        response: NangoUserConnectionsResponse(
          connections: [],
          error: SemurEngineErrorCode.INTERNAL_ERROR,
          message: "Invalid data received from the server",
        ),
      );
    }
    return NangoUserConnectionsResponseWrapper(
      response: NangoUserConnectionsResponse(
        connections:
            (json['connections'] as List)
                .map(
                  (e) => NangoConnectionPublic.create()..mergeFromProto3Json(e),
                )
                .toList(),
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

  Map<String, dynamic> toJsonMap() {
    return response.toProto3Json() as Map<String, dynamic>;
  }
}
