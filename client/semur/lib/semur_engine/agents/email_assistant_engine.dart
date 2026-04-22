import 'package:semur/models.pb/agents/agent.pbserver.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:semur/models.pb/agents/email_assistant.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';
import 'package:semur/semur_engine/semur_engine.dart';

class AgentEmailAssistantEngine {
  static String name = "agent_email_assistant";

  /// Calls the specified endpoint of the Host User Engine.
  static HttpsCallable callEndpoint(bool isDev, String endpoint) {
    return FirebaseFunctions.instance.httpsCallable(
      "${isDev ? '${name}_dev' : name}-$endpoint",
      // WARN: Increase timeout for long-running tasks
      options: HttpsCallableOptions(timeout: const Duration(seconds: 600)),
    );
  }

  /// Generates an API token for the host user.
  static Future<AgentChatOutputWrapper> chat({
    required bool isDev,
    required AgentChatInputWrapper inputModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'chat',
      ).call(inputModel.toJsonMap());

      if (result.data == null || result.data.isEmpty) {
        return AgentChatOutputWrapper(
          response: AgentChatOutput(
            error: SemurEngineErrorCode.NO_DATA_RECEIVED,
            message: "No data returned from the server",
          ),
        );
      }
      return AgentChatOutputWrapper.fromJson(result.data);
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<AgentDemoChatOutputWrapper> demoChat({
    required bool isDev,
    required String userMessage,
    required String sessionId,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'demoChat',
      ).call({
        'userMessage': userMessage,
        'sessionId': sessionId,
      });

      if (result.data == null || result.data.isEmpty) {
        return AgentDemoChatOutputWrapper(
          error: SemurEngineErrorCode.NO_DATA_RECEIVED,
          message: "No data returned from the server",
          chatOutput: "",
          agentTraceOutput: "",
        );
      }
      return AgentDemoChatOutputWrapper.fromJson(
        Map<String, dynamic>.from(result.data),
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }

  static Future<EmailAssistantGenerateResponseEmailOutputWrapper>
  generateEmailResponse({
    required bool isDev,
    required EmailAssistantGenerateResponseEmailInputWrapper inputModel,
  }) async {
    try {
      HttpsCallableResult result = await callEndpoint(
        isDev,
        'generateEmailResponse',
      ).call(inputModel.toJsonMap());
      if (result.data == null || result.data.isEmpty) {
        return EmailAssistantGenerateResponseEmailOutputWrapper(
          response: EmailAssistantGenerateResponseEmailOutput(
            responseEmailSubject: null,
            responseEmailBody: null,
          ),
        );
      }
      return EmailAssistantGenerateResponseEmailOutputWrapper.fromJson(
        result.data,
      );
    } catch (e) {
      throw Exception("${e.toString()}}");
    }
  }
}

// Request Models
class EmailAssistantGenerateResponseEmailInputWrapper {
  final EmailAssistantGenerateResponseEmailInput _input;

  EmailAssistantGenerateResponseEmailInputWrapper({
    required String from,
    required String to,
    required DateTime date,
    required String subject,
    required String body,
  }) : _input = EmailAssistantGenerateResponseEmailInput(
         from: from,
         to: to,
         date: date.toIso8601String(),
         subject: subject,
         body: body,
       );

  Map<String, dynamic> toJsonMap() {
    return _input.toProto3Json() as Map<String, dynamic>;
  }
}

// Response Models
class EmailAssistantGenerateResponseEmailOutputWrapper {
  final EmailAssistantGenerateResponseEmailOutput response;

  EmailAssistantGenerateResponseEmailOutputWrapper({required this.response});

  factory EmailAssistantGenerateResponseEmailOutputWrapper.fromJson(
    Map<String, dynamic> json,
  ) {
    return EmailAssistantGenerateResponseEmailOutputWrapper(
      response: EmailAssistantGenerateResponseEmailOutput(
        responseEmailSubject: json['responseEmailSubject'] ?? "",
        responseEmailBody: json['responseEmailBody'] ?? "",
      ),
    );
  }

  bool validate() {
    if (!(response.hasResponseEmailBody()) ||
        response.responseEmailBody.isEmpty) {
      return false;
    }
    return true;
  }

  bool isSuccess() {
    if (!validate()) {
      return false;
    }
    return true;
  }
}

class AgentDemoChatOutputWrapper {
  final SemurEngineErrorCode error;
  final String message;
  final String chatOutput;
  final String agentTraceOutput;

  const AgentDemoChatOutputWrapper({
    required this.error,
    required this.message,
    required this.chatOutput,
    required this.agentTraceOutput,
  });

  factory AgentDemoChatOutputWrapper.fromJson(Map<String, dynamic> json) {
    return AgentDemoChatOutputWrapper(
      error: toSemurEngineErrorCode(
        json['error'] ?? SemurEngineErrorCode.CUSTOM_ERROR.value,
      ),
      message: json['message'] ?? "",
      chatOutput: json['chatOutput'] ?? "",
      agentTraceOutput: json['agentTraceOutput'] ?? "",
    );
  }

  bool isSuccess() {
    return error == SemurEngineErrorCode.NO_ERROR && message.isNotEmpty;
  }
}
