//
//  Generated code. Do not modify.
//  source: external_apps/external_app.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExternalAppType extends $pb.ProtobufEnum {
  static const ExternalAppType TELEGRAM_BOT = ExternalAppType._(0, _omitEnumNames ? '' : 'TELEGRAM_BOT');

  static const $core.List<ExternalAppType> values = <ExternalAppType> [
    TELEGRAM_BOT,
  ];

  static final $core.Map<$core.int, ExternalAppType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExternalAppType? valueOf($core.int value) => _byValue[value];

  const ExternalAppType._($core.int v, $core.String n) : super(v, n);
}

class ExternalAppIntegrationStatus extends $pb.ProtobufEnum {
  static const ExternalAppIntegrationStatus INACTIVE = ExternalAppIntegrationStatus._(0, _omitEnumNames ? '' : 'INACTIVE');
  static const ExternalAppIntegrationStatus ACTIVE = ExternalAppIntegrationStatus._(1, _omitEnumNames ? '' : 'ACTIVE');
  static const ExternalAppIntegrationStatus DELETED = ExternalAppIntegrationStatus._(2, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<ExternalAppIntegrationStatus> values = <ExternalAppIntegrationStatus> [
    INACTIVE,
    ACTIVE,
    DELETED,
  ];

  static final $core.Map<$core.int, ExternalAppIntegrationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExternalAppIntegrationStatus? valueOf($core.int value) => _byValue[value];

  const ExternalAppIntegrationStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
