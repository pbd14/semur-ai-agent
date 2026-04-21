import 'package:semur/models.pb/semur-engine/nango-engine/google-mail_engine.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class NangoGoogleMailEngine {
  static String name = "nango_google_mail";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
  }

  /// Generates an API token for the host user.
  static Future<NangoGoogleMailSendEmailResponseWrapper> sendEmail({
    required bool isDev,
    required NangoGoogleMailSendEmailRequestWrapper requestModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'sendEmail',
      ).call(requestModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return NangoGoogleMailSendEmailResponseWrapper(
          response: NangoGoogleMailSendEmailResponse(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return NangoGoogleMailSendEmailResponseWrapper.fromJson(result.data);
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class NangoGoogleMailSendEmailRequestWrapper {
  final NangoGoogleMailSendEmailRequest _request;

  NangoGoogleMailSendEmailRequestWrapper({
    required String userId,
    required String to,
    Map<String, String> headers = const {},
    String? subject,
    required String body,
  }) : _request = NangoGoogleMailSendEmailRequest(
         userId: userId,
         to: to,
         headers: headers,
         subject: subject,
         body: body,
       );

  Map<String, dynamic> toJsonMap() {
    return _request.toProto3Json() as Map<String, dynamic>;
  }
}

// Response Models
class NangoGoogleMailSendEmailResponseWrapper {
  final NangoGoogleMailSendEmailResponse response;

  NangoGoogleMailSendEmailResponseWrapper({required this.response});

  factory NangoGoogleMailSendEmailResponseWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return NangoGoogleMailSendEmailResponseWrapper(
      response: NangoGoogleMailSendEmailResponse(
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
