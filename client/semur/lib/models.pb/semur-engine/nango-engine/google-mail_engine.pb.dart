//
//  Generated code. Do not modify.
//  source: semur-engine/nango-engine/google-mail_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../semur_engine.pbenum.dart' as $2;

/// User Connections
class NangoGoogleMailSendEmailRequest extends $pb.GeneratedMessage {
  factory NangoGoogleMailSendEmailRequest({
    $core.String? userId,
    $core.String? to,
    $core.Map<$core.String, $core.String>? headers,
    $core.String? subject,
    $core.String? body,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (to != null) {
      $result.to = to;
    }
    if (headers != null) {
      $result.headers.addAll(headers);
    }
    if (subject != null) {
      $result.subject = subject;
    }
    if (body != null) {
      $result.body = body;
    }
    return $result;
  }
  NangoGoogleMailSendEmailRequest._() : super();
  factory NangoGoogleMailSendEmailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoGoogleMailSendEmailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoGoogleMailSendEmailRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId', protoName: 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'to')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'headers', entryClassName: 'NangoGoogleMailSendEmailRequest.HeadersEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('semur_engine'))
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..aOS(5, _omitFieldNames ? '' : 'body')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoGoogleMailSendEmailRequest clone() => NangoGoogleMailSendEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoGoogleMailSendEmailRequest copyWith(void Function(NangoGoogleMailSendEmailRequest) updates) => super.copyWith((message) => updates(message as NangoGoogleMailSendEmailRequest)) as NangoGoogleMailSendEmailRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoGoogleMailSendEmailRequest create() => NangoGoogleMailSendEmailRequest._();
  NangoGoogleMailSendEmailRequest createEmptyInstance() => create();
  static $pb.PbList<NangoGoogleMailSendEmailRequest> createRepeated() => $pb.PbList<NangoGoogleMailSendEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static NangoGoogleMailSendEmailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoGoogleMailSendEmailRequest>(create);
  static NangoGoogleMailSendEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get to => $_getSZ(1);
  @$pb.TagNumber(2)
  set to($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get headers => $_getMap(2);

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

class NangoGoogleMailSendEmailResponse extends $pb.GeneratedMessage {
  factory NangoGoogleMailSendEmailResponse({
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
  NangoGoogleMailSendEmailResponse._() : super();
  factory NangoGoogleMailSendEmailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NangoGoogleMailSendEmailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NangoGoogleMailSendEmailResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..e<$2.SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: $2.SemurEngineErrorCode.NO_ERROR, valueOf: $2.SemurEngineErrorCode.valueOf, enumValues: $2.SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NangoGoogleMailSendEmailResponse clone() => NangoGoogleMailSendEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NangoGoogleMailSendEmailResponse copyWith(void Function(NangoGoogleMailSendEmailResponse) updates) => super.copyWith((message) => updates(message as NangoGoogleMailSendEmailResponse)) as NangoGoogleMailSendEmailResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NangoGoogleMailSendEmailResponse create() => NangoGoogleMailSendEmailResponse._();
  NangoGoogleMailSendEmailResponse createEmptyInstance() => create();
  static $pb.PbList<NangoGoogleMailSendEmailResponse> createRepeated() => $pb.PbList<NangoGoogleMailSendEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static NangoGoogleMailSendEmailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NangoGoogleMailSendEmailResponse>(create);
  static NangoGoogleMailSendEmailResponse? _defaultInstance;

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
