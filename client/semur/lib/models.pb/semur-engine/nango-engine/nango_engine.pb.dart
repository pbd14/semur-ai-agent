//
//  Generated code. Do not modify.
//  source: semur-engine/nango-engine/nango_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/protobuf/timestamp.pb.dart' as $0;
import '../../nango/nango.pb.dart' as $4;
import '../../syncs/sync.pbenum.dart' as $1;
import '../semur_engine.pbenum.dart' as $2;

/// User Connections
class NangoUserConnectionsRequest extends $pb.GeneratedMessage {
  factory NangoUserConnectionsRequest({
    $core.String? userId,
    $core.String? organizationId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (organizationId != null) {
      $result.organizationId = organizationId;
    }
    return $result;
  }
  NangoUserConnectionsRequest._() : super();
  factory NangoUserConnectionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoUserConnectionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoUserConnectionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'organizationId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoUserConnectionsRequest clone() => NangoUserConnectionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoUserConnectionsRequest copyWith(void Function(NangoUserConnectionsRequest) updates) => super.copyWith((message) => updates(message as NangoUserConnectionsRequest)) as NangoUserConnectionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoUserConnectionsRequest create() => NangoUserConnectionsRequest._();
  NangoUserConnectionsRequest createEmptyInstance() => create();
  static $pb.PbList<NangoUserConnectionsRequest> createRepeated() => $pb.PbList<NangoUserConnectionsRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoUserConnectionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoUserConnectionsRequest>(create);
  static NangoUserConnectionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get organizationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organizationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrganizationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganizationId() => clearField(2);
}

class NangoUserConnectionsResponse extends $pb.GeneratedMessage {
  factory NangoUserConnectionsResponse({
    $2.SemurEngineErrorCode? error,
    $core.String? message,
    $core.Iterable<$4.NangoConnectionPublic>? connections,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    if (message != null) {
      $result.message = message;
    }
    if (connections != null) {
      $result.connections.addAll(connections);
    }
    return $result;
  }
  NangoUserConnectionsResponse._() : super();
  factory NangoUserConnectionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoUserConnectionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoUserConnectionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<$4.NangoConnectionPublic>(3, _omitFieldNames ? '' : 'connections', $pb.PbFieldType.PM, subBuilder: $4.NangoConnectionPublic.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoUserConnectionsResponse clone() => NangoUserConnectionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoUserConnectionsResponse copyWith(void Function(NangoUserConnectionsResponse) updates) => super.copyWith((message) => updates(message as NangoUserConnectionsResponse)) as NangoUserConnectionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoUserConnectionsResponse create() => NangoUserConnectionsResponse._();
  NangoUserConnectionsResponse createEmptyInstance() => create();
  static $pb.PbList<NangoUserConnectionsResponse> createRepeated() => $pb.PbList<NangoUserConnectionsResponse>();
  @$core.pragma('dart2js:noInline')
  static NangoUserConnectionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoUserConnectionsResponse>(create);
  static NangoUserConnectionsResponse? _defaultInstance;

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
  $core.List<$4.NangoConnectionPublic> get connections => $_getList(2);
}

/// Session Token
class NangoSessionTokenRequest extends $pb.GeneratedMessage {
  factory NangoSessionTokenRequest({
    $core.String? integrationId,
    $core.String? userId,
    $core.String? userEmail,
    $core.String? userName,
  }) {
    final $result = create();
    if (integrationId != null) {
      $result.integrationId = integrationId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (userEmail != null) {
      $result.userEmail = userEmail;
    }
    if (userName != null) {
      $result.userName = userName;
    }
    return $result;
  }
  NangoSessionTokenRequest._() : super();
  factory NangoSessionTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoSessionTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoSessionTokenRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'integrationId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'userEmail')
    ..aOS(4, _omitFieldNames ? '' : 'userName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoSessionTokenRequest clone() => NangoSessionTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoSessionTokenRequest copyWith(void Function(NangoSessionTokenRequest) updates) => super.copyWith((message) => updates(message as NangoSessionTokenRequest)) as NangoSessionTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoSessionTokenRequest create() => NangoSessionTokenRequest._();
  NangoSessionTokenRequest createEmptyInstance() => create();
  static $pb.PbList<NangoSessionTokenRequest> createRepeated() => $pb.PbList<NangoSessionTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoSessionTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoSessionTokenRequest>(create);
  static NangoSessionTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get integrationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set integrationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIntegrationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntegrationId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userEmail => $_getSZ(2);
  @$pb.TagNumber(3)
  set userEmail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => clearField(4);
}

class NangoSessionTokenResponse extends $pb.GeneratedMessage {
  factory NangoSessionTokenResponse({
    $2.SemurEngineErrorCode? error,
    $core.String? message,
    $core.String? token,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    if (message != null) {
      $result.message = message;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  NangoSessionTokenResponse._() : super();
  factory NangoSessionTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoSessionTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoSessionTokenResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoSessionTokenResponse clone() => NangoSessionTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoSessionTokenResponse copyWith(void Function(NangoSessionTokenResponse) updates) => super.copyWith((message) => updates(message as NangoSessionTokenResponse)) as NangoSessionTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoSessionTokenResponse create() => NangoSessionTokenResponse._();
  NangoSessionTokenResponse createEmptyInstance() => create();
  static $pb.PbList<NangoSessionTokenResponse> createRepeated() => $pb.PbList<NangoSessionTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static NangoSessionTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoSessionTokenResponse>(create);
  static NangoSessionTokenResponse? _defaultInstance;

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
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);
}

/// Webhook
class NangoConnectionWebhookEndUser extends $pb.GeneratedMessage {
  factory NangoConnectionWebhookEndUser({
    $core.String? endUserId,
    $core.String? organizationId,
  }) {
    final $result = create();
    if (endUserId != null) {
      $result.endUserId = endUserId;
    }
    if (organizationId != null) {
      $result.organizationId = organizationId;
    }
    return $result;
  }
  NangoConnectionWebhookEndUser._() : super();
  factory NangoConnectionWebhookEndUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnectionWebhookEndUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnectionWebhookEndUser', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'endUserId', protoName: 'endUserId')
    ..aOS(2, _omitFieldNames ? '' : 'organizationId', protoName: 'organizationId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookEndUser clone() => NangoConnectionWebhookEndUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookEndUser copyWith(void Function(NangoConnectionWebhookEndUser) updates) => super.copyWith((message) => updates(message as NangoConnectionWebhookEndUser)) as NangoConnectionWebhookEndUser;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookEndUser create() => NangoConnectionWebhookEndUser._();
  NangoConnectionWebhookEndUser createEmptyInstance() => create();
  static $pb.PbList<NangoConnectionWebhookEndUser> createRepeated() => $pb.PbList<NangoConnectionWebhookEndUser>();
  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookEndUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnectionWebhookEndUser>(create);
  static NangoConnectionWebhookEndUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get endUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set endUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEndUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEndUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get organizationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set organizationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrganizationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrganizationId() => clearField(2);
}

class NangoConnectionWebhookError extends $pb.GeneratedMessage {
  factory NangoConnectionWebhookError({
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
  NangoConnectionWebhookError._() : super();
  factory NangoConnectionWebhookError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnectionWebhookError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnectionWebhookError', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookError clone() => NangoConnectionWebhookError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookError copyWith(void Function(NangoConnectionWebhookError) updates) => super.copyWith((message) => updates(message as NangoConnectionWebhookError)) as NangoConnectionWebhookError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookError create() => NangoConnectionWebhookError._();
  NangoConnectionWebhookError createEmptyInstance() => create();
  static $pb.PbList<NangoConnectionWebhookError> createRepeated() => $pb.PbList<NangoConnectionWebhookError>();
  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnectionWebhookError>(create);
  static NangoConnectionWebhookError? _defaultInstance;

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

class NangoConnectionWebhookRequest extends $pb.GeneratedMessage {
  factory NangoConnectionWebhookRequest({
    $core.String? type,
    $core.String? operation,
    $core.String? connectionId,
    $core.String? authMode,
    $core.String? providerConfigKey,
    $core.String? provider,
    $core.String? environment,
    $core.bool? success,
    NangoConnectionWebhookEndUser? endUser,
    NangoConnectionWebhookError? error,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (operation != null) {
      $result.operation = operation;
    }
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (authMode != null) {
      $result.authMode = authMode;
    }
    if (providerConfigKey != null) {
      $result.providerConfigKey = providerConfigKey;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (environment != null) {
      $result.environment = environment;
    }
    if (success != null) {
      $result.success = success;
    }
    if (endUser != null) {
      $result.endUser = endUser;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  NangoConnectionWebhookRequest._() : super();
  factory NangoConnectionWebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoConnectionWebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoConnectionWebhookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'operation')
    ..aOS(3, _omitFieldNames ? '' : 'connectionId')
    ..aOS(4, _omitFieldNames ? '' : 'authMode')
    ..aOS(5, _omitFieldNames ? '' : 'providerConfigKey')
    ..aOS(6, _omitFieldNames ? '' : 'provider')
    ..aOS(7, _omitFieldNames ? '' : 'environment')
    ..aOB(8, _omitFieldNames ? '' : 'success')
    ..aOM<NangoConnectionWebhookEndUser>(9, _omitFieldNames ? '' : 'endUser', subBuilder: NangoConnectionWebhookEndUser.create)
    ..aOM<NangoConnectionWebhookError>(10, _omitFieldNames ? '' : 'error', subBuilder: NangoConnectionWebhookError.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookRequest clone() => NangoConnectionWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoConnectionWebhookRequest copyWith(void Function(NangoConnectionWebhookRequest) updates) => super.copyWith((message) => updates(message as NangoConnectionWebhookRequest)) as NangoConnectionWebhookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookRequest create() => NangoConnectionWebhookRequest._();
  NangoConnectionWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<NangoConnectionWebhookRequest> createRepeated() => $pb.PbList<NangoConnectionWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoConnectionWebhookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoConnectionWebhookRequest>(create);
  static NangoConnectionWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get connectionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set connectionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConnectionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearConnectionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get authMode => $_getSZ(3);
  @$pb.TagNumber(4)
  set authMode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAuthMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthMode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerConfigKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerConfigKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderConfigKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderConfigKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get provider => $_getSZ(5);
  @$pb.TagNumber(6)
  set provider($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProvider() => $_has(5);
  @$pb.TagNumber(6)
  void clearProvider() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get environment => $_getSZ(6);
  @$pb.TagNumber(7)
  set environment($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEnvironment() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnvironment() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get success => $_getBF(7);
  @$pb.TagNumber(8)
  set success($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSuccess() => $_has(7);
  @$pb.TagNumber(8)
  void clearSuccess() => clearField(8);

  @$pb.TagNumber(9)
  NangoConnectionWebhookEndUser get endUser => $_getN(8);
  @$pb.TagNumber(9)
  set endUser(NangoConnectionWebhookEndUser v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEndUser() => $_has(8);
  @$pb.TagNumber(9)
  void clearEndUser() => clearField(9);
  @$pb.TagNumber(9)
  NangoConnectionWebhookEndUser ensureEndUser() => $_ensure(8);

  @$pb.TagNumber(10)
  NangoConnectionWebhookError get error => $_getN(9);
  @$pb.TagNumber(10)
  set error(NangoConnectionWebhookError v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasError() => $_has(9);
  @$pb.TagNumber(10)
  void clearError() => clearField(10);
  @$pb.TagNumber(10)
  NangoConnectionWebhookError ensureError() => $_ensure(9);
}

class NangoSyncWebhookRequest extends $pb.GeneratedMessage {
  factory NangoSyncWebhookRequest({
    $core.String? type,
    $core.String? connectionId,
    $core.String? providerConfigKey,
    $core.String? syncName,
    $core.String? model,
    $core.String? syncType,
    $core.bool? success,
    $0.Timestamp? modifiedAfter,
    NangoSyncWebhookResponseResults? responseResults,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (providerConfigKey != null) {
      $result.providerConfigKey = providerConfigKey;
    }
    if (syncName != null) {
      $result.syncName = syncName;
    }
    if (model != null) {
      $result.model = model;
    }
    if (syncType != null) {
      $result.syncType = syncType;
    }
    if (success != null) {
      $result.success = success;
    }
    if (modifiedAfter != null) {
      $result.modifiedAfter = modifiedAfter;
    }
    if (responseResults != null) {
      $result.responseResults = responseResults;
    }
    return $result;
  }
  NangoSyncWebhookRequest._() : super();
  factory NangoSyncWebhookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoSyncWebhookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoSyncWebhookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aOS(2, _omitFieldNames ? '' : 'connectionId')
    ..aOS(3, _omitFieldNames ? '' : 'providerConfigKey')
    ..aOS(4, _omitFieldNames ? '' : 'syncName')
    ..aOS(5, _omitFieldNames ? '' : 'model')
    ..aOS(6, _omitFieldNames ? '' : 'syncType')
    ..aOB(7, _omitFieldNames ? '' : 'success')
    ..aOM<$0.Timestamp>(8, _omitFieldNames ? '' : 'modifiedAfter', subBuilder: $0.Timestamp.create)
    ..aOM<NangoSyncWebhookResponseResults>(9, _omitFieldNames ? '' : 'responseResults', subBuilder: NangoSyncWebhookResponseResults.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoSyncWebhookRequest clone() => NangoSyncWebhookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoSyncWebhookRequest copyWith(void Function(NangoSyncWebhookRequest) updates) => super.copyWith((message) => updates(message as NangoSyncWebhookRequest)) as NangoSyncWebhookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoSyncWebhookRequest create() => NangoSyncWebhookRequest._();
  NangoSyncWebhookRequest createEmptyInstance() => create();
  static $pb.PbList<NangoSyncWebhookRequest> createRepeated() => $pb.PbList<NangoSyncWebhookRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoSyncWebhookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoSyncWebhookRequest>(create);
  static NangoSyncWebhookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get connectionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set connectionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConnectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConnectionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerConfigKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerConfigKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderConfigKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderConfigKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get syncName => $_getSZ(3);
  @$pb.TagNumber(4)
  set syncName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSyncName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSyncName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get model => $_getSZ(4);
  @$pb.TagNumber(5)
  set model($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasModel() => $_has(4);
  @$pb.TagNumber(5)
  void clearModel() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get syncType => $_getSZ(5);
  @$pb.TagNumber(6)
  set syncType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSyncType() => $_has(5);
  @$pb.TagNumber(6)
  void clearSyncType() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get success => $_getBF(6);
  @$pb.TagNumber(7)
  set success($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSuccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearSuccess() => clearField(7);

  @$pb.TagNumber(8)
  $0.Timestamp get modifiedAfter => $_getN(7);
  @$pb.TagNumber(8)
  set modifiedAfter($0.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasModifiedAfter() => $_has(7);
  @$pb.TagNumber(8)
  void clearModifiedAfter() => clearField(8);
  @$pb.TagNumber(8)
  $0.Timestamp ensureModifiedAfter() => $_ensure(7);

  @$pb.TagNumber(9)
  NangoSyncWebhookResponseResults get responseResults => $_getN(8);
  @$pb.TagNumber(9)
  set responseResults(NangoSyncWebhookResponseResults v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasResponseResults() => $_has(8);
  @$pb.TagNumber(9)
  void clearResponseResults() => clearField(9);
  @$pb.TagNumber(9)
  NangoSyncWebhookResponseResults ensureResponseResults() => $_ensure(8);
}

class NangoSyncWebhookResponseResults extends $pb.GeneratedMessage {
  factory NangoSyncWebhookResponseResults({
    $core.int? added,
    $core.int? updated,
    $core.int? deleted,
  }) {
    final $result = create();
    if (added != null) {
      $result.added = added;
    }
    if (updated != null) {
      $result.updated = updated;
    }
    if (deleted != null) {
      $result.deleted = deleted;
    }
    return $result;
  }
  NangoSyncWebhookResponseResults._() : super();
  factory NangoSyncWebhookResponseResults.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoSyncWebhookResponseResults.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoSyncWebhookResponseResults', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'added', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'updated', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'deleted', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoSyncWebhookResponseResults clone() => NangoSyncWebhookResponseResults()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoSyncWebhookResponseResults copyWith(void Function(NangoSyncWebhookResponseResults) updates) => super.copyWith((message) => updates(message as NangoSyncWebhookResponseResults)) as NangoSyncWebhookResponseResults;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoSyncWebhookResponseResults create() => NangoSyncWebhookResponseResults._();
  NangoSyncWebhookResponseResults createEmptyInstance() => create();
  static $pb.PbList<NangoSyncWebhookResponseResults> createRepeated() => $pb.PbList<NangoSyncWebhookResponseResults>();
  @$core.pragma('dart2js:noInline')
  static NangoSyncWebhookResponseResults getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoSyncWebhookResponseResults>(create);
  static NangoSyncWebhookResponseResults? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get added => $_getIZ(0);
  @$pb.TagNumber(1)
  set added($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAdded() => $_has(0);
  @$pb.TagNumber(1)
  void clearAdded() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get updated => $_getIZ(1);
  @$pb.TagNumber(2)
  set updated($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdated() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdated() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get deleted => $_getIZ(2);
  @$pb.TagNumber(3)
  set deleted($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeleted() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeleted() => clearField(3);
}

class NangoTriggerSyncRequest extends $pb.GeneratedMessage {
  factory NangoTriggerSyncRequest({
    $core.String? providerConfigKey,
    $core.Iterable<$core.String>? syncs,
    $core.String? connectionId,
    $1.SyncMode? syncMode,
    $core.String? userId,
  }) {
    final $result = create();
    if (providerConfigKey != null) {
      $result.providerConfigKey = providerConfigKey;
    }
    if (syncs != null) {
      $result.syncs.addAll(syncs);
    }
    if (connectionId != null) {
      $result.connectionId = connectionId;
    }
    if (syncMode != null) {
      $result.syncMode = syncMode;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  NangoTriggerSyncRequest._() : super();
  factory NangoTriggerSyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoTriggerSyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoTriggerSyncRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerConfigKey')
    ..pPS(2, _omitFieldNames ? '' : 'syncs')
    ..aOS(3, _omitFieldNames ? '' : 'connectionId')
    ..e<$1.SyncMode>(4, _omitFieldNames ? '' : 'syncMode', $pb.PbFieldType.OE, defaultOrMaker: $1.SyncMode.INCREMENTAL, valueOf: $1.SyncMode.valueOf, enumValues: $1.SyncMode.values)
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoTriggerSyncRequest clone() => NangoTriggerSyncRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoTriggerSyncRequest copyWith(void Function(NangoTriggerSyncRequest) updates) => super.copyWith((message) => updates(message as NangoTriggerSyncRequest)) as NangoTriggerSyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoTriggerSyncRequest create() => NangoTriggerSyncRequest._();
  NangoTriggerSyncRequest createEmptyInstance() => create();
  static $pb.PbList<NangoTriggerSyncRequest> createRepeated() => $pb.PbList<NangoTriggerSyncRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoTriggerSyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoTriggerSyncRequest>(create);
  static NangoTriggerSyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerConfigKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerConfigKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderConfigKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderConfigKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get syncs => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get connectionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set connectionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConnectionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearConnectionId() => clearField(3);

  @$pb.TagNumber(4)
  $1.SyncMode get syncMode => $_getN(3);
  @$pb.TagNumber(4)
  set syncMode($1.SyncMode v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSyncMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearSyncMode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => clearField(5);
}

class NangoTriggerSyncResponse extends $pb.GeneratedMessage {
  factory NangoTriggerSyncResponse({
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
  NangoTriggerSyncResponse._() : super();
  factory NangoTriggerSyncResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoTriggerSyncResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoTriggerSyncResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoTriggerSyncResponse clone() => NangoTriggerSyncResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoTriggerSyncResponse copyWith(void Function(NangoTriggerSyncResponse) updates) => super.copyWith((message) => updates(message as NangoTriggerSyncResponse)) as NangoTriggerSyncResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoTriggerSyncResponse create() => NangoTriggerSyncResponse._();
  NangoTriggerSyncResponse createEmptyInstance() => create();
  static $pb.PbList<NangoTriggerSyncResponse> createRepeated() => $pb.PbList<NangoTriggerSyncResponse>();
  @$core.pragma('dart2js:noInline')
  static NangoTriggerSyncResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoTriggerSyncResponse>(create);
  static NangoTriggerSyncResponse? _defaultInstance;

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
