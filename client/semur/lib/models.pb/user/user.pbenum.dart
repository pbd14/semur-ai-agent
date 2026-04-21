//
//  Generated code. Do not modify.
//  source: user/user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UserStatus extends $pb.ProtobufEnum {
  static const UserStatus CREATED = UserStatus._(0, _omitEnumNames ? '' : 'CREATED');
  static const UserStatus UNVERIFIED = UserStatus._(1, _omitEnumNames ? '' : 'UNVERIFIED');
  static const UserStatus VERIFIED = UserStatus._(2, _omitEnumNames ? '' : 'VERIFIED');
  static const UserStatus BLOCKED = UserStatus._(3, _omitEnumNames ? '' : 'BLOCKED');

  static const $core.List<UserStatus> values = <UserStatus> [
    CREATED,
    UNVERIFIED,
    VERIFIED,
    BLOCKED,
  ];

  static final $core.Map<$core.int, UserStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserStatus? valueOf($core.int value) => _byValue[value];

  const UserStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
