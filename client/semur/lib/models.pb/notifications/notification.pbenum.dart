//
//  Generated code. Do not modify.
//  source: notifications/notification.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NotificationStatus extends $pb.ProtobufEnum {
  static const NotificationStatus UNREAD = NotificationStatus._(0, _omitEnumNames ? '' : 'UNREAD');
  static const NotificationStatus READ = NotificationStatus._(1, _omitEnumNames ? '' : 'READ');

  static const $core.List<NotificationStatus> values = <NotificationStatus> [
    UNREAD,
    READ,
  ];

  static final $core.Map<$core.int, NotificationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationStatus? valueOf($core.int value) => _byValue[value];

  const NotificationStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
