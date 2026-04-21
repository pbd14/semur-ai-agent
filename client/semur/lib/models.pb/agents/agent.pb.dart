//
//  Generated code. Do not modify.
//  source: agents/agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../semur-engine/semur_engine.pbenum.dart' as $2;
import 'agent.pbenum.dart';

export 'agent.pbenum.dart';

class AgentChatInput extends $pb.GeneratedMessage {
  factory AgentChatInput({
    $core.String? userId,
    $core.String? sessionId,
    $core.Iterable<$core.String>? connectionIds,
    $core.String? userMessage,
    $core.bool? fastMode,
    $core.bool? proMode,
    AgentMood? agentMood,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (connectionIds != null) {
      $result.connectionIds.addAll(connectionIds);
    }
    if (userMessage != null) {
      $result.userMessage = userMessage;
    }
    if (fastMode != null) {
      $result.fastMode = fastMode;
    }
    if (proMode != null) {
      $result.proMode = proMode;
    }
    if (agentMood != null) {
      $result.agentMood = agentMood;
    }
    return $result;
  }
  AgentChatInput._() : super();
  factory AgentChatInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AgentChatInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AgentChatInput', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId', protoName: 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId', protoName: 'sessionId')
    ..pPS(3, _omitFieldNames ? '' : 'connectionIds', protoName: 'connectionIds')
    ..aOS(4, _omitFieldNames ? '' : 'userMessage', protoName: 'userMessage')
    ..aOB(5, _omitFieldNames ? '' : 'fastMode', protoName: 'fastMode')
    ..aOB(6, _omitFieldNames ? '' : 'proMode', protoName: 'proMode')
    ..e<AgentMood>(7, _omitFieldNames ? '' : 'agentMood', $pb.PbFieldType.OE, protoName: 'agentMood', defaultOrMaker: AgentMood.NORMAL, valueOf: AgentMood.valueOf, enumValues: AgentMood.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AgentChatInput clone() => AgentChatInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AgentChatInput copyWith(void Function(AgentChatInput) updates) => super.copyWith((message) => updates(message as AgentChatInput)) as AgentChatInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AgentChatInput create() => AgentChatInput._();
  AgentChatInput createEmptyInstance() => create();
  static $pb.PbList<AgentChatInput> createRepeated() => $pb.PbList<AgentChatInput>();
  @$core.pragma('dart2js:noInline')
  static AgentChatInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AgentChatInput>(create);
  static AgentChatInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get connectionIds => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get userMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set userMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get fastMode => $_getBF(4);
  @$pb.TagNumber(5)
  set fastMode($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFastMode() => $_has(4);
  @$pb.TagNumber(5)
  void clearFastMode() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get proMode => $_getBF(5);
  @$pb.TagNumber(6)
  set proMode($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProMode() => $_has(5);
  @$pb.TagNumber(6)
  void clearProMode() => clearField(6);

  @$pb.TagNumber(7)
  AgentMood get agentMood => $_getN(6);
  @$pb.TagNumber(7)
  set agentMood(AgentMood v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAgentMood() => $_has(6);
  @$pb.TagNumber(7)
  void clearAgentMood() => clearField(7);
}

class AgentChatOutput extends $pb.GeneratedMessage {
  factory AgentChatOutput({
    $2.SemurEngineErrorCode? error,
    $core.String? message,
    $core.String? chatOutput,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    if (message != null) {
      $result.message = message;
    }
    if (chatOutput != null) {
      $result.chatOutput = chatOutput;
    }
    return $result;
  }
  AgentChatOutput._() : super();
  factory AgentChatOutput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AgentChatOutput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AgentChatOutput', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'chatOutput', protoName: 'chatOutput')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AgentChatOutput clone() => AgentChatOutput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AgentChatOutput copyWith(void Function(AgentChatOutput) updates) => super.copyWith((message) => updates(message as AgentChatOutput)) as AgentChatOutput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AgentChatOutput create() => AgentChatOutput._();
  AgentChatOutput createEmptyInstance() => create();
  static $pb.PbList<AgentChatOutput> createRepeated() => $pb.PbList<AgentChatOutput>();
  @$core.pragma('dart2js:noInline')
  static AgentChatOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AgentChatOutput>(create);
  static AgentChatOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $2.SemurEngineErrorCode get error => $_getN(0);
  @$pb.TagNumber(1)
  set error($2.SemurEngineErrorCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get chatOutput => $_getSZ(2);
  @$pb.TagNumber(3)
  set chatOutput($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChatOutput() => $_has(2);
  @$pb.TagNumber(3)
  void clearChatOutput() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
