//
//  Generated code. Do not modify.
//  source: external_apps/telegram_bot_integration.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TelegramBotIntegrationStatus extends $pb.ProtobufEnum {
  static const TelegramBotIntegrationStatus TELEGRAM_BOT_INACTIVE = TelegramBotIntegrationStatus._(0, _omitEnumNames ? '' : 'TELEGRAM_BOT_INACTIVE');
  static const TelegramBotIntegrationStatus TELEGRAM_BOT_ACTIVE = TelegramBotIntegrationStatus._(1, _omitEnumNames ? '' : 'TELEGRAM_BOT_ACTIVE');
  static const TelegramBotIntegrationStatus TELEGRAM_BOT_DELETED = TelegramBotIntegrationStatus._(2, _omitEnumNames ? '' : 'TELEGRAM_BOT_DELETED');

  static const $core.List<TelegramBotIntegrationStatus> values = <TelegramBotIntegrationStatus> [
    TELEGRAM_BOT_INACTIVE,
    TELEGRAM_BOT_ACTIVE,
    TELEGRAM_BOT_DELETED,
  ];

  static final $core.Map<$core.int, TelegramBotIntegrationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TelegramBotIntegrationStatus? valueOf($core.int value) => _byValue[value];

  const TelegramBotIntegrationStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
