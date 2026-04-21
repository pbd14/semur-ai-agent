//
//  Generated code. Do not modify.
//  source: semur-engine/syncs-engine/sync_engine_outlook-mail.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../semur_engine.pbenum.dart' as $2;
import 'sync_engine.pbenum.dart' as $5;

class SyncOutlookMailEmailsRequest extends $pb.GeneratedMessage {
  factory SyncOutlookMailEmailsRequest({
    $core.String? userId,
    $core.String? integrationId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (integrationId != null) {
      $result.integrationId = integrationId;
    }
    return $result;
  }
  SyncOutlookMailEmailsRequest._() : super();
  factory SyncOutlookMailEmailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncOutlookMailEmailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncOutlookMailEmailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'integrationId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsRequest clone() => SyncOutlookMailEmailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsRequest copyWith(void Function(SyncOutlookMailEmailsRequest) updates) => super.copyWith((message) => updates(message as SyncOutlookMailEmailsRequest)) as SyncOutlookMailEmailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsRequest create() => SyncOutlookMailEmailsRequest._();
  SyncOutlookMailEmailsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncOutlookMailEmailsRequest> createRepeated() => $pb.PbList<SyncOutlookMailEmailsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncOutlookMailEmailsRequest>(create);
  static SyncOutlookMailEmailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get integrationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set integrationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIntegrationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntegrationId() => clearField(2);
}

class SyncOutlookMailEmailsFromNangoToFirestoreRequest extends $pb.GeneratedMessage {
  factory SyncOutlookMailEmailsFromNangoToFirestoreRequest({
    $core.String? userId,
    $core.String? integrationId,
    $core.int? limit,
    $core.Iterable<$5.SyncFilter>? filter,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (integrationId != null) {
      $result.integrationId = integrationId;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (filter != null) {
      $result.filter.addAll(filter);
    }
    return $result;
  }
  SyncOutlookMailEmailsFromNangoToFirestoreRequest._() : super();
  factory SyncOutlookMailEmailsFromNangoToFirestoreRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncOutlookMailEmailsFromNangoToFirestoreRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncOutlookMailEmailsFromNangoToFirestoreRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'integrationId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..pc<$5.SyncFilter>(4, _omitFieldNames ? '' : 'filter', $pb.PbFieldType.KE, valueOf: $5.SyncFilter.valueOf, enumValues: $5.SyncFilter.values, defaultEnumValue: $5.SyncFilter.ADDED)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsFromNangoToFirestoreRequest clone() => SyncOutlookMailEmailsFromNangoToFirestoreRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsFromNangoToFirestoreRequest copyWith(void Function(SyncOutlookMailEmailsFromNangoToFirestoreRequest) updates) => super.copyWith((message) => updates(message as SyncOutlookMailEmailsFromNangoToFirestoreRequest)) as SyncOutlookMailEmailsFromNangoToFirestoreRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsFromNangoToFirestoreRequest create() => SyncOutlookMailEmailsFromNangoToFirestoreRequest._();
  SyncOutlookMailEmailsFromNangoToFirestoreRequest createEmptyInstance() => create();
  static $pb.PbList<SyncOutlookMailEmailsFromNangoToFirestoreRequest> createRepeated() => $pb.PbList<SyncOutlookMailEmailsFromNangoToFirestoreRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsFromNangoToFirestoreRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncOutlookMailEmailsFromNangoToFirestoreRequest>(create);
  static SyncOutlookMailEmailsFromNangoToFirestoreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get integrationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set integrationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIntegrationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearIntegrationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$5.SyncFilter> get filter => $_getList(3);
}

class SyncOutlookMailEmailsFromNangoToFirestoreResponse extends $pb.GeneratedMessage {
  factory SyncOutlookMailEmailsFromNangoToFirestoreResponse({
    $2.SemurEngineErrorCode? error,
    $core.String? message,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SyncOutlookMailEmailsFromNangoToFirestoreResponse._() : super();
  factory SyncOutlookMailEmailsFromNangoToFirestoreResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncOutlookMailEmailsFromNangoToFirestoreResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncOutlookMailEmailsFromNangoToFirestoreResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs_engine'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsFromNangoToFirestoreResponse clone() => SyncOutlookMailEmailsFromNangoToFirestoreResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncOutlookMailEmailsFromNangoToFirestoreResponse copyWith(void Function(SyncOutlookMailEmailsFromNangoToFirestoreResponse) updates) => super.copyWith((message) => updates(message as SyncOutlookMailEmailsFromNangoToFirestoreResponse)) as SyncOutlookMailEmailsFromNangoToFirestoreResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsFromNangoToFirestoreResponse create() => SyncOutlookMailEmailsFromNangoToFirestoreResponse._();
  SyncOutlookMailEmailsFromNangoToFirestoreResponse createEmptyInstance() => create();
  static $pb.PbList<SyncOutlookMailEmailsFromNangoToFirestoreResponse> createRepeated() => $pb.PbList<SyncOutlookMailEmailsFromNangoToFirestoreResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncOutlookMailEmailsFromNangoToFirestoreResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncOutlookMailEmailsFromNangoToFirestoreResponse>(create);
  static SyncOutlookMailEmailsFromNangoToFirestoreResponse? _defaultInstance;

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
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
