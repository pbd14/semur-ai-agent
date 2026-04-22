import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/modules/chat/models/agent_collaboration_trace.dart';

class AgentCollaborationTraceWidget extends StatelessWidget {
  final AgentCollaborationTrace trace;

  const AgentCollaborationTraceWidget({
    super.key,
    required this.trace,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.flowchart,
                size: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Agent Collaboration',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children:
                trace.steps
                    .map((step) => _AgentTraceStepRow(step: step))
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _AgentTraceStepRow extends StatelessWidget {
  final AgentTraceStep step;

  const _AgentTraceStepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              _statusIcon(),
              size: 14,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Text(
                      step.displayName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: statusColor.withValues(alpha: 0.12),
                      ),
                      child: Text(
                        _statusLabel(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  step.outputSummary,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightDarkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _statusIcon() {
    switch (step.status) {
      case AgentTraceStatus.completed:
        return CupertinoIcons.checkmark_circle_fill;
      case AgentTraceStatus.skipped:
        return CupertinoIcons.minus_circle_fill;
      case AgentTraceStatus.failed:
        return CupertinoIcons.exclamationmark_circle_fill;
    }
  }

  Color _statusColor() {
    switch (step.status) {
      case AgentTraceStatus.completed:
        return AppColors.primaryColor;
      case AgentTraceStatus.skipped:
        return AppColors.lightDarkColor;
      case AgentTraceStatus.failed:
        return Colors.redAccent;
    }
  }

  String _statusLabel() {
    switch (step.status) {
      case AgentTraceStatus.completed:
        return 'completed';
      case AgentTraceStatus.skipped:
        return 'skipped';
      case AgentTraceStatus.failed:
        return 'failed';
    }
  }
}
