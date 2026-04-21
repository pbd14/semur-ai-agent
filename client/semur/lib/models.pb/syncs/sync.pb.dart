//
//  Generated code. Do not modify.
//  source: syncs/sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'sync.pbenum.dart';

export 'sync.pbenum.dart';

class SyncInformation extends $pb.GeneratedMessage {
  factory SyncInformation({
    $core.String? id,
    $core.String? nangoIntegrationId,
    $0.Timestamp? updatedAt,
    $core.String? nangoNextCursor,
    SyncStatus? status,
    $core.String? errorMessage,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (nangoIntegrationId != null) {
      $result.nangoIntegrationId = nangoIntegrationId;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (nangoNextCursor != null) {
      $result.nangoNextCursor = nangoNextCursor;
    }
    if (status != null) {
      $result.status = status;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    return $result;
  }
  SyncInformation._() : super();
  factory SyncInformation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncInformation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncInformation', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'nangoIntegrationId')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'updatedAt', subBuilder: $0.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'nangoNextCursor')
    ..e<SyncStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SyncStatus.PENDING, valueOf: SyncStatus.valueOf, enumValues: SyncStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncInformation clone() => SyncInformation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncInformation copyWith(void Function(SyncInformation) updates) => super.copyWith((message) => updates(message as SyncInformation)) as SyncInformation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncInformation create() => SyncInformation._();
  SyncInformation createEmptyInstance() => create();
  static $pb.PbList<SyncInformation> createRepeated() => $pb.PbList<SyncInformation>();
  @$core.pragma('dart2js:noInline')
  static SyncInformation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncInformation>(create);
  static SyncInformation? _defaultInstance;

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
  $0.Timestamp get updatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set updatedAt($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureUpdatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get nangoNextCursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set nangoNextCursor($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNangoNextCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearNangoNextCursor() => clearField(4);

  @$pb.TagNumber(5)
  SyncStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(SyncStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get errorMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set errorMessage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasErrorMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearErrorMessage() => clearField(6);
}

class SyncNangoMetadata extends $pb.GeneratedMessage {
  factory SyncNangoMetadata({
    $0.Timestamp? deletedAt,
    $core.String? lastAction,
    $0.Timestamp? firstSeenAt,
    $core.String? cursor,
    $0.Timestamp? lastModifiedAt,
  }) {
    final $result = create();
    if (deletedAt != null) {
      $result.deletedAt = deletedAt;
    }
    if (lastAction != null) {
      $result.lastAction = lastAction;
    }
    if (firstSeenAt != null) {
      $result.firstSeenAt = firstSeenAt;
    }
    if (cursor != null) {
      $result.cursor = cursor;
    }
    if (lastModifiedAt != null) {
      $result.lastModifiedAt = lastModifiedAt;
    }
    return $result;
  }
  SyncNangoMetadata._() : super();
  factory SyncNangoMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncNangoMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncNangoMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, _omitFieldNames ? '' : 'deletedAt', subBuilder: $0.Timestamp.create)
    ..aOS(2, _omitFieldNames ? '' : 'lastAction')
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'firstSeenAt', subBuilder: $0.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'cursor')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'lastModifiedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncNangoMetadata clone() => SyncNangoMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncNangoMetadata copyWith(void Function(SyncNangoMetadata) updates) => super.copyWith((message) => updates(message as SyncNangoMetadata)) as SyncNangoMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncNangoMetadata create() => SyncNangoMetadata._();
  SyncNangoMetadata createEmptyInstance() => create();
  static $pb.PbList<SyncNangoMetadata> createRepeated() => $pb.PbList<SyncNangoMetadata>();
  @$core.pragma('dart2js:noInline')
  static SyncNangoMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncNangoMetadata>(create);
  static SyncNangoMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get deletedAt => $_getN(0);
  @$pb.TagNumber(1)
  set deletedAt($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeletedAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeletedAt() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureDeletedAt() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get lastAction => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastAction($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastAction() => clearField(2);

  @$pb.TagNumber(3)
  $0.Timestamp get firstSeenAt => $_getN(2);
  @$pb.TagNumber(3)
  set firstSeenAt($0.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstSeenAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstSeenAt() => clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureFirstSeenAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get cursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set cursor($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearCursor() => clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get lastModifiedAt => $_getN(4);
  @$pb.TagNumber(5)
  set lastModifiedAt($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastModifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastModifiedAt() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureLastModifiedAt() => $_ensure(4);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
