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

class NangoIntegrationStatus extends $pb.ProtobufEnum {
  static const NangoIntegrationStatus INACTIVE = NangoIntegrationStatus._(0, _omitEnumNames ? '' : 'INACTIVE');
  static const NangoIntegrationStatus ACTIVE = NangoIntegrationStatus._(1, _omitEnumNames ? '' : 'ACTIVE');

  static const $core.List<NangoIntegrationStatus> values = <NangoIntegrationStatus> [
    INACTIVE,
    ACTIVE,
  ];

  static final $core.Map<$core.int, NangoIntegrationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NangoIntegrationStatus? valueOf($core.int value) => _byValue[value];

  const NangoIntegrationStatus._($core.int v, $core.String n) : super(v, n);
}

class NangoConnectionStatus extends $pb.ProtobufEnum {
  static const NangoConnectionStatus NANGO_CONNECTION_INACTIVE = NangoConnectionStatus._(0, _omitEnumNames ? '' : 'NANGO_CONNECTION_INACTIVE');
  static const NangoConnectionStatus NANGO_CONNECTION_ACTIVE = NangoConnectionStatus._(1, _omitEnumNames ? '' : 'NANGO_CONNECTION_ACTIVE');
  static const NangoConnectionStatus NANGO_CONNECTION_CONNECTING = NangoConnectionStatus._(2, _omitEnumNames ? '' : 'NANGO_CONNECTION_CONNECTING');

  static const $core.List<NangoConnectionStatus> values = <NangoConnectionStatus> [
    NANGO_CONNECTION_INACTIVE,
    NANGO_CONNECTION_ACTIVE,
    NANGO_CONNECTION_CONNECTING,
  ];

  static final $core.Map<$core.int, NangoConnectionStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NangoConnectionStatus? valueOf($core.int value) => _byValue[value];

  const NangoConnectionStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
