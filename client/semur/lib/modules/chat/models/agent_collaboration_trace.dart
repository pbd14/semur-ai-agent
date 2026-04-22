import 'dart:convert';

enum AgentTraceStatus {
  completed,
  skipped,
  failed,
}

class AgentCollaborationTrace {
  final List<AgentTraceStep> steps;

  const AgentCollaborationTrace({required this.steps});

  static AgentCollaborationTrace? tryParse(String output) {
    if (output.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(output);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      final rawTrace = decoded['agentTrace'];
      if (rawTrace is! List || rawTrace.isEmpty) {
        return null;
      }

      final steps =
          rawTrace
              .whereType<Map<String, dynamic>>()
              .map(AgentTraceStep.fromMap)
              .where((step) => step.displayName.isNotEmpty)
              .toList();

      if (steps.isEmpty) {
        return null;
      }
      return AgentCollaborationTrace(steps: steps);
    } catch (_) {
      return null;
    }
  }
}

class AgentTraceStep {
  final String agentId;
  final String displayName;
  final String reason;
  final AgentTraceStatus status;
  final String inputSummary;
  final String outputSummary;
  final List<String> evidenceIds;

  const AgentTraceStep({
    required this.agentId,
    required this.displayName,
    required this.reason,
    required this.status,
    required this.inputSummary,
    required this.outputSummary,
    required this.evidenceIds,
  });

  factory AgentTraceStep.fromMap(Map<String, dynamic> map) {
    return AgentTraceStep(
      agentId: map['agentId']?.toString() ?? '',
      displayName: map['displayName']?.toString() ?? '',
      reason: map['reason']?.toString() ?? '',
      status: _parseStatus(map['status']?.toString()),
      inputSummary: map['inputSummary']?.toString() ?? '',
      outputSummary: map['outputSummary']?.toString() ?? '',
      evidenceIds:
          (map['evidenceIds'] as List<dynamic>? ?? [])
              .map((id) => id.toString())
              .toList(),
    );
  }

  static AgentTraceStatus _parseStatus(String? value) {
    switch (value) {
      case 'completed':
        return AgentTraceStatus.completed;
      case 'skipped':
        return AgentTraceStatus.skipped;
      case 'failed':
        return AgentTraceStatus.failed;
      default:
        return AgentTraceStatus.failed;
    }
  }
}
