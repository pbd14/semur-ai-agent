//
//  Generated code. Do not modify.
//  source: semur-engine/semur_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'semur_engine.pbenum.dart';

export 'semur_engine.pbenum.dart';

class SemurEngineResponse extends $pb.GeneratedMessage {
  factory SemurEngineResponse({
    SemurEngineErrorCode? error,
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
  SemurEngineResponse._() : super();
  factory SemurEngineResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SemurEngineResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SemurEngineResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'semur_engine'), createEmptyInstance: create)
    ..e<SemurEngineErrorCode>(1, _omitFieldNames ? '' : 'error', $pb.PbFieldType.OE, defaultOrMaker: SemurEngineErrorCode.NO_ERROR, valueOf: SemurEngineErrorCode.valueOf, enumValues: SemurEngineErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SemurEngineResponse clone() => SemurEngineResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SemurEngineResponse copyWith(void Function(SemurEngineResponse) updates) => super.copyWith((message) => updates(message as SemurEngineResponse)) as SemurEngineResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SemurEngineResponse create() => SemurEngineResponse._();
  SemurEngineResponse createEmptyInstance() => create();
  static $pb.PbList<SemurEngineResponse> createRepeated() => $pb.PbList<SemurEngineResponse>();
  @$core.pragma('dart2js:noInline')
  static SemurEngineResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SemurEngineResponse>(create);
  static SemurEngineResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SemurEngineErrorCode get error => $_getN(0);
  @$pb.TagNumber(1)
  set error(SemurEngineErrorCode v) { setField(1, v); }
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
