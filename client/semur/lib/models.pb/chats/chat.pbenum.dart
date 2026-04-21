//
//  Generated code. Do not modify.
//  source: chats/chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChatRole extends $pb.ProtobufEnum {
  static const ChatRole USER = ChatRole._(0, _omitEnumNames ? '' : 'USER');
  static const ChatRole MODEL = ChatRole._(1, _omitEnumNames ? '' : 'MODEL');
  static const ChatRole SYSTEM = ChatRole._(2, _omitEnumNames ? '' : 'SYSTEM');
  static const ChatRole TOOL = ChatRole._(3, _omitEnumNames ? '' : 'TOOL');

  static const $core.List<ChatRole> values = <ChatRole> [
    USER,
    MODEL,
    SYSTEM,
    TOOL,
  ];

  static final $core.Map<$core.int, ChatRole> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChatRole? valueOf($core.int value) => _byValue[value];

  const ChatRole._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
