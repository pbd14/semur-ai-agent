//
//  Generated code. Do not modify.
//  source: syncs/sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SyncMode extends $pb.ProtobufEnum {
  static const SyncMode INCREMENTAL = SyncMode._(0, _omitEnumNames ? '' : 'INCREMENTAL');
  static const SyncMode FULL_REFRESH = SyncMode._(1, _omitEnumNames ? '' : 'FULL_REFRESH');
  static const SyncMode FULL_REFRESH_AND_CLEAR_CACHE = SyncMode._(2, _omitEnumNames ? '' : 'FULL_REFRESH_AND_CLEAR_CACHE');

  static const $core.List<SyncMode> values = <SyncMode> [
    INCREMENTAL,
    FULL_REFRESH,
    FULL_REFRESH_AND_CLEAR_CACHE,
  ];

  static final $core.Map<$core.int, SyncMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SyncMode? valueOf($core.int value) => _byValue[value];

  const SyncMode._($core.int v, $core.String n) : super(v, n);
}

class SyncStatus extends $pb.ProtobufEnum {
  static const SyncStatus PENDING = SyncStatus._(0, _omitEnumNames ? '' : 'PENDING');
  static const SyncStatus IN_PROGRESS = SyncStatus._(1, _omitEnumNames ? '' : 'IN_PROGRESS');
  static const SyncStatus COMPLETED = SyncStatus._(2, _omitEnumNames ? '' : 'COMPLETED');
  static const SyncStatus FAILED = SyncStatus._(3, _omitEnumNames ? '' : 'FAILED');
  static const SyncStatus PARTIALLY_COMPLETED = SyncStatus._(4, _omitEnumNames ? '' : 'PARTIALLY_COMPLETED');

  static const $core.List<SyncStatus> values = <SyncStatus> [
    PENDING,
    IN_PROGRESS,
    COMPLETED,
    FAILED,
    PARTIALLY_COMPLETED,
  ];

  static final $core.Map<$core.int, SyncStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SyncStatus? valueOf($core.int value) => _byValue[value];

  const SyncStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
