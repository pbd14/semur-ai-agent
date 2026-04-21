//
//  Generated code. Do not modify.
//  source: agents/agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AgentCategory extends $pb.ProtobufEnum {
  static const AgentCategory GENERAL = AgentCategory._(0, _omitEnumNames ? '' : 'GENERAL');
  static const AgentCategory EMAIL = AgentCategory._(1, _omitEnumNames ? '' : 'EMAIL');
  static const AgentCategory CALENDAR = AgentCategory._(2, _omitEnumNames ? '' : 'CALENDAR');

  static const $core.List<AgentCategory> values = <AgentCategory> [
    GENERAL,
    EMAIL,
    CALENDAR,
  ];

  static final $core.Map<$core.int, AgentCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AgentCategory? valueOf($core.int value) => _byValue[value];

  const AgentCategory._($core.int v, $core.String n) : super(v, n);
}

class AgentTool extends $pb.ProtobufEnum {
  static const AgentTool SEMUR_CHAT_MENTION_EMAIL = AgentTool._(0, _omitEnumNames ? '' : 'SEMUR_CHAT_MENTION_EMAIL');
  static const AgentTool GOOGLE_MAIL_GET_EMAILS = AgentTool._(10, _omitEnumNames ? '' : 'GOOGLE_MAIL_GET_EMAILS');
  static const AgentTool GOOGLE_MAIL_GET_EMAIL_BY_ID = AgentTool._(11, _omitEnumNames ? '' : 'GOOGLE_MAIL_GET_EMAIL_BY_ID');
  static const AgentTool GOOGLE_MAIL_SEARCH_COMMON_FILTERS = AgentTool._(12, _omitEnumNames ? '' : 'GOOGLE_MAIL_SEARCH_COMMON_FILTERS');
  static const AgentTool GOOGLE_MAIL_VECTOR_SEARCH = AgentTool._(13, _omitEnumNames ? '' : 'GOOGLE_MAIL_VECTOR_SEARCH');
  static const AgentTool GOOGLE_MAIL_GET_SYNC_INFORMATION = AgentTool._(14, _omitEnumNames ? '' : 'GOOGLE_MAIL_GET_SYNC_INFORMATION');
  static const AgentTool GOOGLE_MAIL_SYNC = AgentTool._(15, _omitEnumNames ? '' : 'GOOGLE_MAIL_SYNC');
  static const AgentTool GOOGLE_MAIL_SEND_EMAIL = AgentTool._(16, _omitEnumNames ? '' : 'GOOGLE_MAIL_SEND_EMAIL');
  static const AgentTool GOOGLE_CALENDAR_GET_EVENTS = AgentTool._(20, _omitEnumNames ? '' : 'GOOGLE_CALENDAR_GET_EVENTS');
  static const AgentTool GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS = AgentTool._(21, _omitEnumNames ? '' : 'GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS');
  static const AgentTool GOOGLE_CALENDAR_VECTOR_SEARCH = AgentTool._(22, _omitEnumNames ? '' : 'GOOGLE_CALENDAR_VECTOR_SEARCH');
  static const AgentTool GOOGLE_CALENDAR_GET_SYNC_INFORMATION = AgentTool._(23, _omitEnumNames ? '' : 'GOOGLE_CALENDAR_GET_SYNC_INFORMATION');
  static const AgentTool GOOGLE_CALENDAR_SYNC = AgentTool._(24, _omitEnumNames ? '' : 'GOOGLE_CALENDAR_SYNC');
  static const AgentTool OUTLOOK_MAIL_GET_EMAILS = AgentTool._(30, _omitEnumNames ? '' : 'OUTLOOK_MAIL_GET_EMAILS');
  static const AgentTool OUTLOOK_MAIL_GET_EMAIL_BY_ID = AgentTool._(31, _omitEnumNames ? '' : 'OUTLOOK_MAIL_GET_EMAIL_BY_ID');
  static const AgentTool OUTLOOK_MAIL_SEARCH_COMMON_FILTERS = AgentTool._(32, _omitEnumNames ? '' : 'OUTLOOK_MAIL_SEARCH_COMMON_FILTERS');
  static const AgentTool OUTLOOK_MAIL_VECTOR_SEARCH = AgentTool._(33, _omitEnumNames ? '' : 'OUTLOOK_MAIL_VECTOR_SEARCH');
  static const AgentTool OUTLOOK_MAIL_GET_SYNC_INFORMATION = AgentTool._(34, _omitEnumNames ? '' : 'OUTLOOK_MAIL_GET_SYNC_INFORMATION');
  static const AgentTool OUTLOOK_MAIL_SYNC = AgentTool._(35, _omitEnumNames ? '' : 'OUTLOOK_MAIL_SYNC');
  static const AgentTool OUTLOOK_MAIL_SEND_EMAIL = AgentTool._(36, _omitEnumNames ? '' : 'OUTLOOK_MAIL_SEND_EMAIL');

  static const $core.List<AgentTool> values = <AgentTool> [
    SEMUR_CHAT_MENTION_EMAIL,
    GOOGLE_MAIL_GET_EMAILS,
    GOOGLE_MAIL_GET_EMAIL_BY_ID,
    GOOGLE_MAIL_SEARCH_COMMON_FILTERS,
    GOOGLE_MAIL_VECTOR_SEARCH,
    GOOGLE_MAIL_GET_SYNC_INFORMATION,
    GOOGLE_MAIL_SYNC,
    GOOGLE_MAIL_SEND_EMAIL,
    GOOGLE_CALENDAR_GET_EVENTS,
    GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS,
    GOOGLE_CALENDAR_VECTOR_SEARCH,
    GOOGLE_CALENDAR_GET_SYNC_INFORMATION,
    GOOGLE_CALENDAR_SYNC,
    OUTLOOK_MAIL_GET_EMAILS,
    OUTLOOK_MAIL_GET_EMAIL_BY_ID,
    OUTLOOK_MAIL_SEARCH_COMMON_FILTERS,
    OUTLOOK_MAIL_VECTOR_SEARCH,
    OUTLOOK_MAIL_GET_SYNC_INFORMATION,
    OUTLOOK_MAIL_SYNC,
    OUTLOOK_MAIL_SEND_EMAIL,
  ];

  static final $core.Map<$core.int, AgentTool> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AgentTool? valueOf($core.int value) => _byValue[value];

  const AgentTool._($core.int v, $core.String n) : super(v, n);
}

class AgentMood extends $pb.ProtobufEnum {
  static const AgentMood NORMAL = AgentMood._(0, _omitEnumNames ? '' : 'NORMAL');
  static const AgentMood DETERMINISTIC = AgentMood._(1, _omitEnumNames ? '' : 'DETERMINISTIC');
  static const AgentMood CAREFUL = AgentMood._(2, _omitEnumNames ? '' : 'CAREFUL');
  static const AgentMood CREATIVE = AgentMood._(3, _omitEnumNames ? '' : 'CREATIVE');
  static const AgentMood WILD = AgentMood._(4, _omitEnumNames ? '' : 'WILD');

  static const $core.List<AgentMood> values = <AgentMood> [
    NORMAL,
    DETERMINISTIC,
    CAREFUL,
    CREATIVE,
    WILD,
  ];

  static final $core.Map<$core.int, AgentMood> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AgentMood? valueOf($core.int value) => _byValue[value];

  const AgentMood._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
