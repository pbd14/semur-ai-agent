//
//  Generated code. Do not modify.
//  source: agents/email_assistant.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EmailAssistantMentionedEmail extends $pb.GeneratedMessage {
  factory EmailAssistantMentionedEmail({
    $core.String? id,
    $core.String? nangoIntegrationId,
    $core.String? provider,
    $core.String? subject,
    $core.String? senderName,
    $core.String? senderEmail,
    $core.String? snippet,
    $core.String? date,
    $core.double? importanceScore,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (nangoIntegrationId != null) {
      $result.nangoIntegrationId = nangoIntegrationId;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (senderName != null) {
      $result.senderName = senderName;
    }
    if (senderEmail != null) {
      $result.senderEmail = senderEmail;
    }
    if (snippet != null) {
      $result.snippet = snippet;
    }
    if (date != null) {
      $result.date = date;
    }
    if (importanceScore != null) {
      $result.importanceScore = importanceScore;
    }
    return $result;
  }
  EmailAssistantMentionedEmail._() : super();
  factory EmailAssistantMentionedEmail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantMentionedEmail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantMentionedEmail', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'nangoIntegrationId', protoName: 'nangoIntegrationId')
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'senderName', protoName: 'senderName')
    ..aOS(6, _omitFieldNames ? '' : 'senderEmail', protoName: 'senderEmail')
    ..aOS(7, _omitFieldNames ? '' : 'snippet')
    ..aOS(8, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'importanceScore', $pb.PbFieldType.OF, protoName: 'importanceScore')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantMentionedEmail clone() => EmailAssistantMentionedEmail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantMentionedEmail copyWith(void Function(EmailAssistantMentionedEmail) updates) => super.copyWith((message) => updates(message as EmailAssistantMentionedEmail)) as EmailAssistantMentionedEmail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantMentionedEmail create() => EmailAssistantMentionedEmail._();
  EmailAssistantMentionedEmail createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantMentionedEmail> createRepeated() => $pb.PbList<EmailAssistantMentionedEmail>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantMentionedEmail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantMentionedEmail>(create);
  static EmailAssistantMentionedEmail? _defaultInstance;

  /// TODO: This has limited options
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nangoIntegrationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set nangoIntegrationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNangoIntegrationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNangoIntegrationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get senderName => $_getSZ(4);
  @$pb.TagNumber(5)
  set senderName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSenderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get senderEmail => $_getSZ(5);
  @$pb.TagNumber(6)
  set senderEmail($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSenderEmail() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderEmail() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get snippet => $_getSZ(6);
  @$pb.TagNumber(7)
  set snippet($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSnippet() => $_has(6);
  @$pb.TagNumber(7)
  void clearSnippet() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get date => $_getSZ(7);
  @$pb.TagNumber(8)
  set date($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get importanceScore => $_getN(8);
  @$pb.TagNumber(9)
  set importanceScore($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasImportanceScore() => $_has(8);
  @$pb.TagNumber(9)
  void clearImportanceScore() => clearField(9);
}

class EmailAssistantSuggestedReply extends $pb.GeneratedMessage {
  factory EmailAssistantSuggestedReply({
    $core.String? replyText,
    $core.String? replySubject,
  }) {
    final $result = create();
    if (replyText != null) {
      $result.replyText = replyText;
    }
    if (replySubject != null) {
      $result.replySubject = replySubject;
    }
    return $result;
  }
  EmailAssistantSuggestedReply._() : super();
  factory EmailAssistantSuggestedReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantSuggestedReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantSuggestedReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'replyText', protoName: 'replyText')
    ..aOS(2, _omitFieldNames ? '' : 'replySubject', protoName: 'replySubject')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantSuggestedReply clone() => EmailAssistantSuggestedReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantSuggestedReply copyWith(void Function(EmailAssistantSuggestedReply) updates) => super.copyWith((message) => updates(message as EmailAssistantSuggestedReply)) as EmailAssistantSuggestedReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantSuggestedReply create() => EmailAssistantSuggestedReply._();
  EmailAssistantSuggestedReply createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantSuggestedReply> createRepeated() => $pb.PbList<EmailAssistantSuggestedReply>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantSuggestedReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantSuggestedReply>(create);
  static EmailAssistantSuggestedReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get replyText => $_getSZ(0);
  @$pb.TagNumber(1)
  set replyText($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReplyText() => $_has(0);
  @$pb.TagNumber(1)
  void clearReplyText() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get replySubject => $_getSZ(1);
  @$pb.TagNumber(2)
  set replySubject($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReplySubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplySubject() => clearField(2);
}

class EmailAssistantChatOutput extends $pb.GeneratedMessage {
  factory EmailAssistantChatOutput({
    $core.String? replyText,
    EmailAssistantChatArtifacts? artifacts,
    EmailAssistantChatMetadata? metadata,
  }) {
    final $result = create();
    if (replyText != null) {
      $result.replyText = replyText;
    }
    if (artifacts != null) {
      $result.artifacts = artifacts;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    return $result;
  }
  EmailAssistantChatOutput._() : super();
  factory EmailAssistantChatOutput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantChatOutput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantChatOutput', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'replyText', protoName: 'replyText')
    ..aOM<EmailAssistantChatArtifacts>(2, _omitFieldNames ? '' : 'artifacts', subBuilder: EmailAssistantChatArtifacts.create)
    ..aOM<EmailAssistantChatMetadata>(3, _omitFieldNames ? '' : 'metadata', subBuilder: EmailAssistantChatMetadata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantChatOutput clone() => EmailAssistantChatOutput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantChatOutput copyWith(void Function(EmailAssistantChatOutput) updates) => super.copyWith((message) => updates(message as EmailAssistantChatOutput)) as EmailAssistantChatOutput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatOutput create() => EmailAssistantChatOutput._();
  EmailAssistantChatOutput createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantChatOutput> createRepeated() => $pb.PbList<EmailAssistantChatOutput>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantChatOutput>(create);
  static EmailAssistantChatOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get replyText => $_getSZ(0);
  @$pb.TagNumber(1)
  set replyText($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReplyText() => $_has(0);
  @$pb.TagNumber(1)
  void clearReplyText() => clearField(1);

  @$pb.TagNumber(2)
  EmailAssistantChatArtifacts get artifacts => $_getN(1);
  @$pb.TagNumber(2)
  set artifacts(EmailAssistantChatArtifacts v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasArtifacts() => $_has(1);
  @$pb.TagNumber(2)
  void clearArtifacts() => clearField(2);
  @$pb.TagNumber(2)
  EmailAssistantChatArtifacts ensureArtifacts() => $_ensure(1);

  @$pb.TagNumber(3)
  EmailAssistantChatMetadata get metadata => $_getN(2);
  @$pb.TagNumber(3)
  set metadata(EmailAssistantChatMetadata v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMetadata() => $_has(2);
  @$pb.TagNumber(3)
  void clearMetadata() => clearField(3);
  @$pb.TagNumber(3)
  EmailAssistantChatMetadata ensureMetadata() => $_ensure(2);
}

class EmailAssistantChatArtifacts extends $pb.GeneratedMessage {
  factory EmailAssistantChatArtifacts({
    $core.Iterable<EmailAssistantMentionedEmail>? mentionedEmails,
  }) {
    final $result = create();
    if (mentionedEmails != null) {
      $result.mentionedEmails.addAll(mentionedEmails);
    }
    return $result;
  }
  EmailAssistantChatArtifacts._() : super();
  factory EmailAssistantChatArtifacts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantChatArtifacts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantChatArtifacts', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..pc<EmailAssistantMentionedEmail>(1, _omitFieldNames ? '' : 'mentionedEmails', $pb.PbFieldType.PM, protoName: 'mentionedEmails', subBuilder: EmailAssistantMentionedEmail.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantChatArtifacts clone() => EmailAssistantChatArtifacts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantChatArtifacts copyWith(void Function(EmailAssistantChatArtifacts) updates) => super.copyWith((message) => updates(message as EmailAssistantChatArtifacts)) as EmailAssistantChatArtifacts;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatArtifacts create() => EmailAssistantChatArtifacts._();
  EmailAssistantChatArtifacts createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantChatArtifacts> createRepeated() => $pb.PbList<EmailAssistantChatArtifacts>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatArtifacts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantChatArtifacts>(create);
  static EmailAssistantChatArtifacts? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EmailAssistantMentionedEmail> get mentionedEmails => $_getList(0);
}

class EmailAssistantChatMetadata extends $pb.GeneratedMessage {
  factory EmailAssistantChatMetadata({
    $core.int? totalEmailsAnalyzed,
    $core.String? timeRange,
  }) {
    final $result = create();
    if (totalEmailsAnalyzed != null) {
      $result.totalEmailsAnalyzed = totalEmailsAnalyzed;
    }
    if (timeRange != null) {
      $result.timeRange = timeRange;
    }
    return $result;
  }
  EmailAssistantChatMetadata._() : super();
  factory EmailAssistantChatMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantChatMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantChatMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalEmailsAnalyzed', $pb.PbFieldType.O3, protoName: 'totalEmailsAnalyzed')
    ..aOS(2, _omitFieldNames ? '' : 'timeRange', protoName: 'timeRange')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantChatMetadata clone() => EmailAssistantChatMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantChatMetadata copyWith(void Function(EmailAssistantChatMetadata) updates) => super.copyWith((message) => updates(message as EmailAssistantChatMetadata)) as EmailAssistantChatMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatMetadata create() => EmailAssistantChatMetadata._();
  EmailAssistantChatMetadata createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantChatMetadata> createRepeated() => $pb.PbList<EmailAssistantChatMetadata>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantChatMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantChatMetadata>(create);
  static EmailAssistantChatMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalEmailsAnalyzed => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalEmailsAnalyzed($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalEmailsAnalyzed() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalEmailsAnalyzed() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get timeRange => $_getSZ(1);
  @$pb.TagNumber(2)
  set timeRange($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeRange() => clearField(2);
}

class EmailAssistantGenerateResponseEmailInput extends $pb.GeneratedMessage {
  factory EmailAssistantGenerateResponseEmailInput({
    $core.String? from,
    $core.String? to,
    $core.String? date,
    $core.String? subject,
    $core.String? body,
  }) {
    final $result = create();
    if (from != null) {
      $result.from = from;
    }
    if (to != null) {
      $result.to = to;
    }
    if (date != null) {
      $result.date = date;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (body != null) {
      $result.body = body;
    }
    return $result;
  }
  EmailAssistantGenerateResponseEmailInput._() : super();
  factory EmailAssistantGenerateResponseEmailInput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantGenerateResponseEmailInput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantGenerateResponseEmailInput', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'from')
    ..aOS(2, _omitFieldNames ? '' : 'to')
    ..aOS(3, _omitFieldNames ? '' : 'date')
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantGenerateResponseEmailInput clone() => EmailAssistantGenerateResponseEmailInput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantGenerateResponseEmailInput copyWith(void Function(EmailAssistantGenerateResponseEmailInput) updates) => super.copyWith((message) => updates(message as EmailAssistantGenerateResponseEmailInput)) as EmailAssistantGenerateResponseEmailInput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantGenerateResponseEmailInput create() => EmailAssistantGenerateResponseEmailInput._();
  EmailAssistantGenerateResponseEmailInput createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantGenerateResponseEmailInput> createRepeated() => $pb.PbList<EmailAssistantGenerateResponseEmailInput>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantGenerateResponseEmailInput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantGenerateResponseEmailInput>(create);
  static EmailAssistantGenerateResponseEmailInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get from => $_getSZ(0);
  @$pb.TagNumber(1)
  set from($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get to => $_getSZ(1);
  @$pb.TagNumber(2)
  set to($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get date => $_getSZ(2);
  @$pb.TagNumber(3)
  set date($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get body => $_getSZ(4);
  @$pb.TagNumber(5)
  set body($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBody() => $_has(4);
  @$pb.TagNumber(5)
  void clearBody() => clearField(5);
}

class EmailAssistantGenerateResponseEmailOutput extends $pb.GeneratedMessage {
  factory EmailAssistantGenerateResponseEmailOutput({
    $core.String? responseEmailSubject,
    $core.String? responseEmailBody,
  }) {
    final $result = create();
    if (responseEmailSubject != null) {
      $result.responseEmailSubject = responseEmailSubject;
    }
    if (responseEmailBody != null) {
      $result.responseEmailBody = responseEmailBody;
    }
    return $result;
  }
  EmailAssistantGenerateResponseEmailOutput._() : super();
  factory EmailAssistantGenerateResponseEmailOutput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmailAssistantGenerateResponseEmailOutput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmailAssistantGenerateResponseEmailOutput', package: const $pb.PackageName(_omitMessageNames ? '' : 'agents'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'responseEmailSubject', protoName: 'responseEmailSubject')
    ..aOS(2, _omitFieldNames ? '' : 'responseEmailBody', protoName: 'responseEmailBody')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmailAssistantGenerateResponseEmailOutput clone() => EmailAssistantGenerateResponseEmailOutput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmailAssistantGenerateResponseEmailOutput copyWith(void Function(EmailAssistantGenerateResponseEmailOutput) updates) => super.copyWith((message) => updates(message as EmailAssistantGenerateResponseEmailOutput)) as EmailAssistantGenerateResponseEmailOutput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmailAssistantGenerateResponseEmailOutput create() => EmailAssistantGenerateResponseEmailOutput._();
  EmailAssistantGenerateResponseEmailOutput createEmptyInstance() => create();
  static $pb.PbList<EmailAssistantGenerateResponseEmailOutput> createRepeated() => $pb.PbList<EmailAssistantGenerateResponseEmailOutput>();
  @$core.pragma('dart2js:noInline')
  static EmailAssistantGenerateResponseEmailOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmailAssistantGenerateResponseEmailOutput>(create);
  static EmailAssistantGenerateResponseEmailOutput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get responseEmailSubject => $_getSZ(0);
  @$pb.TagNumber(1)
  set responseEmailSubject($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponseEmailSubject() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponseEmailSubject() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get responseEmailBody => $_getSZ(1);
  @$pb.TagNumber(2)
  set responseEmailBody($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResponseEmailBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponseEmailBody() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
