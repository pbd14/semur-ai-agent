//
//  Generated code. Do not modify.
//  source: semur-engine/syncs-engine/sync_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SyncFilter extends $pb.ProtobufEnum {
  static const SyncFilter ADDED = SyncFilter._(0, _omitEnumNames ? '' : 'ADDED');
  static const SyncFilter UPDATED = SyncFilter._(1, _omitEnumNames ? '' : 'UPDATED');
  static const SyncFilter DELETED = SyncFilter._(2, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<SyncFilter> values = <SyncFilter> [
    ADDED,
    UPDATED,
    DELETED,
  ];

  static final $core.Map<$core.int, SyncFilter> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SyncFilter? valueOf($core.int value) => _byValue[value];

  const SyncFilter._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
