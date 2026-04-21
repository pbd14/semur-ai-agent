//
//  Generated code. Do not modify.
//  source: chats/chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../agents/agent.pbenum.dart' as $3;
import '../agents/email_assistant.pb.dart' as $8;
import '../google/protobuf/timestamp.pb.dart' as $0;
import 'chat.pbenum.dart';

export 'chat.pbenum.dart';

class ChatMessage extends $pb.GeneratedMessage {
  factory ChatMessage({
    $core.int? id,
    ChatRole? role,
    $core.String? author,
    $core.String? content,
    $core.Iterable<$core.String>? followUpQuestions,
    ChatMetadata? metadata,
    ChatArtifacts? artifacts,
    $core.String? output,
    $core.String? toolName,
    $core.String? toolRequestJson,
    $core.String? toolResponseJson,
    $0.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (role != null) {
      $result.role = role;
    }
    if (author != null) {
      $result.author = author;
    }
    if (content != null) {
      $result.content = content;
    }
    if (followUpQuestions != null) {
      $result.followUpQuestions.addAll(followUpQuestions);
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (artifacts != null) {
      $result.artifacts = artifacts;
    }
    if (output != null) {
      $result.output = output;
    }
    if (toolName != null) {
      $result.toolName = toolName;
    }
    if (toolRequestJson != null) {
      $result.toolRequestJson = toolRequestJson;
    }
    if (toolResponseJson != null) {
      $result.toolResponseJson = toolResponseJson;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  ChatMessage._() : super();
  factory ChatMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'chats'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..e<ChatRole>(2, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: ChatRole.USER, valueOf: ChatRole.valueOf, enumValues: ChatRole.values)
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..pPS(5, _omitFieldNames ? '' : 'followUpQuestions')
    ..aOM<ChatMetadata>(6, _omitFieldNames ? '' : 'metadata', subBuilder: ChatMetadata.create)
    ..aOM<ChatArtifacts>(7, _omitFieldNames ? '' : 'artifacts', subBuilder: ChatArtifacts.create)
    ..aOS(8, _omitFieldNames ? '' : 'output')
    ..aOS(9, _omitFieldNames ? '' : 'toolName', protoName: 'toolName')
    ..aOS(10, _omitFieldNames ? '' : 'toolRequestJson', protoName: 'toolRequestJson')
    ..aOS(11, _omitFieldNames ? '' : 'toolResponseJson', protoName: 'toolResponseJson')
    ..aOM<$0.Timestamp>(12, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatMessage clone() => ChatMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatMessage copyWith(void Function(ChatMessage) updates) => super.copyWith((message) => updates(message as ChatMessage)) as ChatMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMessage create() => ChatMessage._();
  ChatMessage createEmptyInstance() => create();
  static $pb.PbList<ChatMessage> createRepeated() => $pb.PbList<ChatMessage>();
  @$core.pragma('dart2js:noInline')
  static ChatMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatMessage>(create);
  static ChatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  ChatRole get role => $_getN(1);
  @$pb.TagNumber(2)
  set role(ChatRole v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get followUpQuestions => $_getList(4);

  /// Metadata about the message
  @$pb.TagNumber(6)
  ChatMetadata get metadata => $_getN(5);
  @$pb.TagNumber(6)
  set metadata(ChatMetadata v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMetadata() => $_has(5);
  @$pb.TagNumber(6)
  void clearMetadata() => clearField(6);
  @$pb.TagNumber(6)
  ChatMetadata ensureMetadata() => $_ensure(5);

  @$pb.TagNumber(7)
  ChatArtifacts get artifacts => $_getN(6);
  @$pb.TagNumber(7)
  set artifacts(ChatArtifacts v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasArtifacts() => $_has(6);
  @$pb.TagNumber(7)
  void clearArtifacts() => clearField(7);
  @$pb.TagNumber(7)
  ChatArtifacts ensureArtifacts() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get output => $_getSZ(7);
  @$pb.TagNumber(8)
  set output($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOutput() => $_has(7);
  @$pb.TagNumber(8)
  void clearOutput() => clearField(8);

  /// Tool-specific metadata
  @$pb.TagNumber(9)
  $core.String get toolName => $_getSZ(8);
  @$pb.TagNumber(9)
  set toolName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasToolName() => $_has(8);
  @$pb.TagNumber(9)
  void clearToolName() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get toolRequestJson => $_getSZ(9);
  @$pb.TagNumber(10)
  set toolRequestJson($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasToolRequestJson() => $_has(9);
  @$pb.TagNumber(10)
  void clearToolRequestJson() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get toolResponseJson => $_getSZ(10);
  @$pb.TagNumber(11)
  set toolResponseJson($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasToolResponseJson() => $_has(10);
  @$pb.TagNumber(11)
  void clearToolResponseJson() => clearField(11);

  @$pb.TagNumber(12)
  $0.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($0.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $0.Timestamp ensureCreatedAt() => $_ensure(11);
}

class ChatMetadata extends $pb.GeneratedMessage {
  factory ChatMetadata({
    $8.EmailAssistantChatMetadata? emailAssistant,
  }) {
    final $result = create();
    if (emailAssistant != null) {
      $result.emailAssistant = emailAssistant;
    }
    return $result;
  }
  ChatMetadata._() : super();
  factory ChatMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'chats'), createEmptyInstance: create)
    ..aOM<$8.EmailAssistantChatMetadata>(1, _omitFieldNames ? '' : 'emailAssistant', subBuilder: $8.EmailAssistantChatMetadata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatMetadata clone() => ChatMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatMetadata copyWith(void Function(ChatMetadata) updates) => super.copyWith((message) => updates(message as ChatMetadata)) as ChatMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatMetadata create() => ChatMetadata._();
  ChatMetadata createEmptyInstance() => create();
  static $pb.PbList<ChatMetadata> createRepeated() => $pb.PbList<ChatMetadata>();
  @$core.pragma('dart2js:noInline')
  static ChatMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatMetadata>(create);
  static ChatMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $8.EmailAssistantChatMetadata get emailAssistant => $_getN(0);
  @$pb.TagNumber(1)
  set emailAssistant($8.EmailAssistantChatMetadata v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmailAssistant() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmailAssistant() => clearField(1);
  @$pb.TagNumber(1)
  $8.EmailAssistantChatMetadata ensureEmailAssistant() => $_ensure(0);
}

class ChatArtifacts extends $pb.GeneratedMessage {
  factory ChatArtifacts({
    $8.EmailAssistantChatArtifacts? emailAssistant,
  }) {
    final $result = create();
    if (emailAssistant != null) {
      $result.emailAssistant = emailAssistant;
    }
    return $result;
  }
  ChatArtifacts._() : super();
  factory ChatArtifacts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatArtifacts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatArtifacts', package: const $pb.PackageName(_omitMessageNames ? '' : 'chats'), createEmptyInstance: create)
    ..aOM<$8.EmailAssistantChatArtifacts>(1, _omitFieldNames ? '' : 'emailAssistant', subBuilder: $8.EmailAssistantChatArtifacts.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatArtifacts clone() => ChatArtifacts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatArtifacts copyWith(void Function(ChatArtifacts) updates) => super.copyWith((message) => updates(message as ChatArtifacts)) as ChatArtifacts;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatArtifacts create() => ChatArtifacts._();
  ChatArtifacts createEmptyInstance() => create();
  static $pb.PbList<ChatArtifacts> createRepeated() => $pb.PbList<ChatArtifacts>();
  @$core.pragma('dart2js:noInline')
  static ChatArtifacts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatArtifacts>(create);
  static ChatArtifacts? _defaultInstance;

  @$pb.TagNumber(1)
  $8.EmailAssistantChatArtifacts get emailAssistant => $_getN(0);
  @$pb.TagNumber(1)
  set emailAssistant($8.EmailAssistantChatArtifacts v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmailAssistant() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmailAssistant() => clearField(1);
  @$pb.TagNumber(1)
  $8.EmailAssistantChatArtifacts ensureEmailAssistant() => $_ensure(0);
}

class ChatSession extends $pb.GeneratedMessage {
  factory ChatSession({
    $core.String? id,
    $core.String? userId,
    $3.AgentCategory? agentCategory,
    $core.int? currentMessageIndex,
    $0.Timestamp? createdAt,
    $core.String? title,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (agentCategory != null) {
      $result.agentCategory = agentCategory;
    }
    if (currentMessageIndex != null) {
      $result.currentMessageIndex = currentMessageIndex;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (title != null) {
      $result.title = title;
    }
    return $result;
  }
  ChatSession._() : super();
  factory ChatSession.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatSession.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatSession', package: const $pb.PackageName(_omitMessageNames ? '' : 'chats'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<$3.AgentCategory>(3, _omitFieldNames ? '' : 'agentCategory', $pb.PbFieldType.OE, defaultOrMaker: $3.AgentCategory.GENERAL, valueOf: $3.AgentCategory.valueOf, enumValues: $3.AgentCategory.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentMessageIndex', $pb.PbFieldType.O3)
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOS(6, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatSession clone() => ChatSession()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatSession copyWith(void Function(ChatSession) updates) => super.copyWith((message) => updates(message as ChatSession)) as ChatSession;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatSession create() => ChatSession._();
  ChatSession createEmptyInstance() => create();
  static $pb.PbList<ChatSession> createRepeated() => $pb.PbList<ChatSession>();
  @$core.pragma('dart2js:noInline')
  static ChatSession getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatSession>(create);
  static ChatSession? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $3.AgentCategory get agentCategory => $_getN(2);
  @$pb.TagNumber(3)
  set agentCategory($3.AgentCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAgentCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearAgentCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentMessageIndex => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentMessageIndex($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentMessageIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentMessageIndex() => clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(6)
  set title($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitle() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
