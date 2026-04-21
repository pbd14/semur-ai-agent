//
//  Generated code. Do not modify.
//  source: syncs/sync_outlook.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'sync.pb.dart' as $1;

class SyncOutlookEmail extends $pb.GeneratedMessage {
  factory SyncOutlookEmail({
    $core.String? id,
    $core.String? sender,
    $core.String? recipients,
    $0.Timestamp? date,
    $core.String? subject,
    $core.String? body,
    $core.String? fullContent,
    $core.Iterable<SyncOutlookEmailAttachment>? attachments,
    $core.String? threadId,
    $1.SyncNangoMetadata? nangoMetadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (sender != null) {
      $result.sender = sender;
    }
    if (recipients != null) {
      $result.recipients = recipients;
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
    if (fullContent != null) {
      $result.fullContent = fullContent;
    }
    if (attachments != null) {
      $result.attachments.addAll(attachments);
    }
    if (threadId != null) {
      $result.threadId = threadId;
    }
    if (nangoMetadata != null) {
      $result.nangoMetadata = nangoMetadata;
    }
    return $result;
  }
  SyncOutlookEmail._() : super();
  factory SyncOutlookEmail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncOutlookEmail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncOutlookEmail', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'sender')
    ..aOS(3, _omitFieldNames ? '' : 'recipients')
    ..aOM<$0.Timestamp>(4, _omitFieldNames ? '' : 'date', subBuilder: $0.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'subject')
    ..aOS(6, _omitFieldNames ? '' : 'body')
    ..aOS(7, _omitFieldNames ? '' : 'fullContent')
    ..pc<SyncOutlookEmailAttachment>(8, _omitFieldNames ? '' : 'attachments', $pb.PbFieldType.PM, subBuilder: SyncOutlookEmailAttachment.create)
    ..aOS(9, _omitFieldNames ? '' : 'threadId', protoName: 'threadId')
    ..aOM<$1.SyncNangoMetadata>(10, _omitFieldNames ? '' : 'nangoMetadata', subBuilder: $1.SyncNangoMetadata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncOutlookEmail clone() => SyncOutlookEmail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncOutlookEmail copyWith(void Function(SyncOutlookEmail) updates) => super.copyWith((message) => updates(message as SyncOutlookEmail)) as SyncOutlookEmail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncOutlookEmail create() => SyncOutlookEmail._();
  SyncOutlookEmail createEmptyInstance() => create();
  static $pb.PbList<SyncOutlookEmail> createRepeated() => $pb.PbList<SyncOutlookEmail>();
  @$core.pragma('dart2js:noInline')
  static SyncOutlookEmail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncOutlookEmail>(create);
  static SyncOutlookEmail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sender => $_getSZ(1);
  @$pb.TagNumber(2)
  set sender($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipients => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipients($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipients() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipients() => clearField(3);

  @$pb.TagNumber(4)
  $0.Timestamp get date => $_getN(3);
  @$pb.TagNumber(4)
  set date($0.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get subject => $_getSZ(4);
  @$pb.TagNumber(5)
  set subject($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSubject() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubject() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get body => $_getSZ(5);
  @$pb.TagNumber(6)
  set body($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBody() => $_has(5);
  @$pb.TagNumber(6)
  void clearBody() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fullContent => $_getSZ(6);
  @$pb.TagNumber(7)
  set fullContent($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFullContent() => $_has(6);
  @$pb.TagNumber(7)
  void clearFullContent() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<SyncOutlookEmailAttachment> get attachments => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get threadId => $_getSZ(8);
  @$pb.TagNumber(9)
  set threadId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasThreadId() => $_has(8);
  @$pb.TagNumber(9)
  void clearThreadId() => clearField(9);

  @$pb.TagNumber(10)
  $1.SyncNangoMetadata get nangoMetadata => $_getN(9);
  @$pb.TagNumber(10)
  set nangoMetadata($1.SyncNangoMetadata v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasNangoMetadata() => $_has(9);
  @$pb.TagNumber(10)
  void clearNangoMetadata() => clearField(10);
  @$pb.TagNumber(10)
  $1.SyncNangoMetadata ensureNangoMetadata() => $_ensure(9);
}

class SyncOutlookEmailAttachment extends $pb.GeneratedMessage {
  factory SyncOutlookEmailAttachment({
    $core.String? filename,
    $core.String? mimeType,
    $core.int? size,
    $core.String? attachmentId,
  }) {
    final $result = create();
    if (filename != null) {
      $result.filename = filename;
    }
    if (mimeType != null) {
      $result.mimeType = mimeType;
    }
    if (size != null) {
      $result.size = size;
    }
    if (attachmentId != null) {
      $result.attachmentId = attachmentId;
    }
    return $result;
  }
  SyncOutlookEmailAttachment._() : super();
  factory SyncOutlookEmailAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncOutlookEmailAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncOutlookEmailAttachment', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'filename')
    ..aOS(2, _omitFieldNames ? '' : 'mimeType', protoName: 'mimeType')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'size', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'attachmentId', protoName: 'attachmentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncOutlookEmailAttachment clone() => SyncOutlookEmailAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncOutlookEmailAttachment copyWith(void Function(SyncOutlookEmailAttachment) updates) => super.copyWith((message) => updates(message as SyncOutlookEmailAttachment)) as SyncOutlookEmailAttachment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncOutlookEmailAttachment create() => SyncOutlookEmailAttachment._();
  SyncOutlookEmailAttachment createEmptyInstance() => create();
  static $pb.PbList<SyncOutlookEmailAttachment> createRepeated() => $pb.PbList<SyncOutlookEmailAttachment>();
  @$core.pragma('dart2js:noInline')
  static SyncOutlookEmailAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncOutlookEmailAttachment>(create);
  static SyncOutlookEmailAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get filename => $_getSZ(0);
  @$pb.TagNumber(1)
  set filename($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFilename() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilename() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mimeType => $_getSZ(1);
  @$pb.TagNumber(2)
  set mimeType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMimeType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMimeType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get size => $_getIZ(2);
  @$pb.TagNumber(3)
  set size($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get attachmentId => $_getSZ(3);
  @$pb.TagNumber(4)
  set attachmentId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttachmentId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentId() => clearField(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
