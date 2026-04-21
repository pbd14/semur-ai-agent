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

class SemurEngineErrorCode extends $pb.ProtobufEnum {
  static const SemurEngineErrorCode NO_ERROR = SemurEngineErrorCode._(0, _omitEnumNames ? '' : 'NO_ERROR');
  static const SemurEngineErrorCode CUSTOM_ERROR = SemurEngineErrorCode._(100, _omitEnumNames ? '' : 'CUSTOM_ERROR');
  static const SemurEngineErrorCode NO_DATA_RECEIVED = SemurEngineErrorCode._(101, _omitEnumNames ? '' : 'NO_DATA_RECEIVED');
  static const SemurEngineErrorCode INTERNAL_ERROR = SemurEngineErrorCode._(1, _omitEnumNames ? '' : 'INTERNAL_ERROR');
  static const SemurEngineErrorCode BAD_REQUEST = SemurEngineErrorCode._(2, _omitEnumNames ? '' : 'BAD_REQUEST');
  static const SemurEngineErrorCode UNAUTHORIZED = SemurEngineErrorCode._(3, _omitEnumNames ? '' : 'UNAUTHORIZED');
  static const SemurEngineErrorCode NOT_FOUND = SemurEngineErrorCode._(4, _omitEnumNames ? '' : 'NOT_FOUND');
  static const SemurEngineErrorCode METHOD_NOT_ALLOWED = SemurEngineErrorCode._(5, _omitEnumNames ? '' : 'METHOD_NOT_ALLOWED');
  static const SemurEngineErrorCode CONFLICT = SemurEngineErrorCode._(6, _omitEnumNames ? '' : 'CONFLICT');
  static const SemurEngineErrorCode TOO_MANY_REQUESTS = SemurEngineErrorCode._(7, _omitEnumNames ? '' : 'TOO_MANY_REQUESTS');
  static const SemurEngineErrorCode UNAVAILABLE = SemurEngineErrorCode._(8, _omitEnumNames ? '' : 'UNAVAILABLE');
  static const SemurEngineErrorCode PERMISSION_DENIED = SemurEngineErrorCode._(9, _omitEnumNames ? '' : 'PERMISSION_DENIED');
  static const SemurEngineErrorCode NANGO_ERROR = SemurEngineErrorCode._(10, _omitEnumNames ? '' : 'NANGO_ERROR');
  static const SemurEngineErrorCode NANGO_SESSION_TOKEN_ERROR = SemurEngineErrorCode._(11, _omitEnumNames ? '' : 'NANGO_SESSION_TOKEN_ERROR');
  static const SemurEngineErrorCode NANGO_CONNECTION_ERROR = SemurEngineErrorCode._(12, _omitEnumNames ? '' : 'NANGO_CONNECTION_ERROR');
  static const SemurEngineErrorCode AGENT_ERROR = SemurEngineErrorCode._(20, _omitEnumNames ? '' : 'AGENT_ERROR');
  static const SemurEngineErrorCode AGENT_NO_INTEGRATION = SemurEngineErrorCode._(21, _omitEnumNames ? '' : 'AGENT_NO_INTEGRATION');
  static const SemurEngineErrorCode AGENT_MODEL_ERROR = SemurEngineErrorCode._(22, _omitEnumNames ? '' : 'AGENT_MODEL_ERROR');

  static const $core.List<SemurEngineErrorCode> values = <SemurEngineErrorCode> [
    NO_ERROR,
    CUSTOM_ERROR,
    NO_DATA_RECEIVED,
    INTERNAL_ERROR,
    BAD_REQUEST,
    UNAUTHORIZED,
    NOT_FOUND,
    METHOD_NOT_ALLOWED,
    CONFLICT,
    TOO_MANY_REQUESTS,
    UNAVAILABLE,
    PERMISSION_DENIED,
    NANGO_ERROR,
    NANGO_SESSION_TOKEN_ERROR,
    NANGO_CONNECTION_ERROR,
    AGENT_ERROR,
    AGENT_NO_INTEGRATION,
    AGENT_MODEL_ERROR,
  ];

  static final $core.Map<$core.int, SemurEngineErrorCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SemurEngineErrorCode? valueOf($core.int value) => _byValue[value];

  const SemurEngineErrorCode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
