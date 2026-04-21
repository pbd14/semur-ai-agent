//
//  Generated code. Do not modify.
//  source: nango/nango.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../agents/agent.pbenum.dart' as $3;
import '../google/protobuf/timestamp.pb.dart' as $0;
import 'nango.pbenum.dart';

export 'nango.pbenum.dart';

class NangoIntegration extends $pb.GeneratedMessage {
  factory NangoIntegration({
    $core.String? id,
    $core.String? name,
    NangoIntegrationStatus? status,
    $core.Iterable<$3.AgentCategory>? categories,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (status != null) {
      $result.status = status;
    }
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    return $result;
  }
  NangoIntegration._() : super();
  factory NangoIntegration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoIntegration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoIntegration', package: const $pb.PackageName(_omitMessageNames ? '' : 'nango'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..e<NangoIntegrationStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NangoIntegrationStatus.INACTIVE, valueOf: NangoIntegrationStatus.valueOf, enumValues: NangoIntegrationStatus.values)
    ..pc<$3.AgentCategory>(4, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.KE, valueOf: $3.AgentCategory.valueOf, enumValues: $3.AgentCategory.values, defaultEnumValue: $3.AgentCategory.GENERAL)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoIntegration clone() => NangoIntegration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoIntegration copyWith(void Function(NangoIntegration) updates) => super.copyWith((message) => updates(message as NangoIntegration)) as NangoIntegration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoIntegration create() => NangoIntegration._();
  NangoIntegration createEmptyInstance() => create();
  static $pb.PbList<NangoIntegration> createRepeated() => $pb.PbList<NangoIntegration>();
  @$core.pragma('dart2js:noInline')
  static NangoIntegration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoIntegration>(create);
  static NangoIntegration? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  NangoIntegrationStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(NangoIntegrationStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$3.AgentCategory> get categories => $_getList(3);
}

class NangoConnectionError extends $pb.GeneratedMessage {
  factory NangoConnectionError({
    $core.String? type,
    $core.String? message,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  NangoConnectionError._() : super();
  factory NangoConnectionError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnectionError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnectionError', package: const $pb.PackageName(_omitMessageNames ? '' : 'nango'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnectionError clone() => NangoConnectionError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnectionError copyWith(void Function(NangoConnectionError) updates) => super.copyWith((message) => updates(message as NangoConnectionError)) as NangoConnectionError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnectionError create() => NangoConnectionError._();
  NangoConnectionError createEmptyInstance() => create();
  static $pb.PbList<NangoConnectionError> createRepeated() => $pb.PbList<NangoConnectionError>();
  @$core.pragma('dart2js:noInline')
  static NangoConnectionError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnectionError>(create);
  static NangoConnectionError? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class NangoConnection extends $pb.GeneratedMessage {
  factory NangoConnection({
    $core.String? id,
    $core.String? userId,
    $core.String? connectionId,
    $core.String? organizationId,
    NangoConnectionStatus? status,
    $core.String? provider,
    $core.String? authMode,
    NangoConnectionError? nangoError,
    $0.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (organizationId != null) {
      $result.organizationId = organizationId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (authMode != null) {
      $result.authMode = authMode;
    }
    if (nangoError != null) {
      $result.nangoError = nangoError;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  NangoConnection._() : super();
  factory NangoConnection.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnection.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnection', package: const $pb.PackageName(_omitMessageNames ? '' : 'nango'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'connectionId')
    ..aOS(4, _omitFieldNames ? '' : 'organizationId')
    ..e<NangoConnectionStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NangoConnectionStatus.NANGO_CONNECTION_INACTIVE, valueOf: NangoConnectionStatus.valueOf, enumValues: NangoConnectionStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'provider')
    ..aOS(7, _omitFieldNames ? '' : 'authMode')
    ..aOM<NangoConnectionError>(8, _omitFieldNames ? '' : 'nangoError', subBuilder: NangoConnectionError.create)
    ..aOM<$0.Timestamp>(9, _omitFieldNames ? '' : 'updatedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnection clone() => NangoConnection()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnection copyWith(void Function(NangoConnection) updates) => super.copyWith((message) => updates(message as NangoConnection)) as NangoConnection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnection create() => NangoConnection._();
  NangoConnection createEmptyInstance() => create();
  static $pb.PbList<NangoConnection> createRepeated() => $pb.PbList<NangoConnection>();
  @$core.pragma('dart2js:noInline')
  static NangoConnection getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnection>(create);
  static NangoConnection? _defaultInstance;

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
  $core.String get connectionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set connectionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConnectionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearConnectionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get organizationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set organizationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrganizationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrganizationId() => clearField(4);

  @$pb.TagNumber(5)
  NangoConnectionStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NangoConnectionStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get provider => $_getSZ(5);
  @$pb.TagNumber(6)
  set provider($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProvider() => $_has(5);
  @$pb.TagNumber(6)
  void clearProvider() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get authMode => $_getSZ(6);
  @$pb.TagNumber(7)
  set authMode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAuthMode() => $_has(6);
  @$pb.TagNumber(7)
  void clearAuthMode() => clearField(7);

  @$pb.TagNumber(8)
  NangoConnectionError get nangoError => $_getN(7);
  @$pb.TagNumber(8)
  set nangoError(NangoConnectionError v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasNangoError() => $_has(7);
  @$pb.TagNumber(8)
  void clearNangoError() => clearField(8);
  @$pb.TagNumber(8)
  NangoConnectionError ensureNangoError() => $_ensure(7);

  @$pb.TagNumber(9)
  $0.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($0.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $0.Timestamp ensureUpdatedAt() => $_ensure(8);
}

class NangoConnectionPublic extends $pb.GeneratedMessage {
  factory NangoConnectionPublic({
    $core.String? id,
    $core.String? userId,
    $core.String? organizationId,
    NangoConnectionStatus? status,
    $core.String? provider,
    $0.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (organizationId != null) {
      $result.organizationId = organizationId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  NangoConnectionPublic._() : super();
  factory NangoConnectionPublic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnectionPublic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnectionPublic', package: const $pb.PackageName(_omitMessageNames ? '' : 'nango'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'organizationId')
    ..e<NangoConnectionStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NangoConnectionStatus.NANGO_CONNECTION_INACTIVE, valueOf: NangoConnectionStatus.valueOf, enumValues: NangoConnectionStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'updatedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnectionPublic clone() => NangoConnectionPublic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnectionPublic copyWith(void Function(NangoConnectionPublic) updates) => super.copyWith((message) => updates(message as NangoConnectionPublic)) as NangoConnectionPublic;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnectionPublic create() => NangoConnectionPublic._();
  NangoConnectionPublic createEmptyInstance() => create();
  static $pb.PbList<NangoConnectionPublic> createRepeated() => $pb.PbList<NangoConnectionPublic>();
  @$core.pragma('dart2js:noInline')
  static NangoConnectionPublic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnectionPublic>(create);
  static NangoConnectionPublic? _defaultInstance;

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
  $core.String get organizationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set organizationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOrganizationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrganizationId() => clearField(3);

  @$pb.TagNumber(4)
  NangoConnectionStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(NangoConnectionStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => clearField(5);

  @$pb.TagNumber(6)
  $0.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($0.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureUpdatedAt() => $_ensure(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
