import 'package:semur/models.pb/agents/agent.pb.dart';
import 'package:semur/models.pb/semur-engine/semur_engine.pbenum.dart';

/// Converts a `SemurEngineErrorCode` to an integer representation.
int toIntFromSemurEngineErrorCode(SemurEngineErrorCode error) {
  return error.value;
}

/// Converts an integer representation to a `SemurEngineErrorCode`.
SemurEngineErrorCode toSemurEngineErrorCode(int code) {
  return SemurEngineErrorCode.valueOf(code) ?? SemurEngineErrorCode.CUSTOM_ERROR;
}

// AI
// Request Models
class AgentChatInputWrapper {
  final AgentChatInput _input;

  AgentChatInputWrapper({
    required String userId,
    required String sessionId,
    required List<String> connectionIds,
    required String userMessage,
    required bool fastMode,
    required bool proMode,
    required AgentMood agentMood,
  }) : _input = AgentChatInput(
         userId: userId,
         sessionId: sessionId,
         connectionIds: connectionIds,
         userMessage: userMessage,
         fastMode: fastMode,
         proMode: proMode,
         agentMood: agentMood,
       );

  Map<String, dynamic> toJsonMap() {
    return _input.toProto3Json() as Map<String, dynamic>;
  }
}

// Response Models
class AgentChatOutputWrapper {
  final AgentChatOutput response;

  AgentChatOutputWrapper({
    required this.response,
  });

  factory AgentChatOutputWrapper.fromJson(
      Map<String, dynamic> json) {
    return AgentChatOutputWrapper(
      response: AgentChatOutput(
        error: toSemurEngineErrorCode(
            json['error'] ?? SemurEngineErrorCode.CUSTOM_ERROR.value),
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