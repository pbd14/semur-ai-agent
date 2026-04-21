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

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'notification.pbenum.dart';

export 'notification.pbenum.dart';

class NotificationApp extends $pb.GeneratedMessage {
  factory NotificationApp({
    $core.String? id,
    $core.String? userId,
    $core.Map<$core.String, $core.String>? title,
    $core.Map<$core.String, $core.String>? description,
    NotificationStatus? status,
    $0.Timestamp? createdAt,
    $0.Timestamp? deathAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (title != null) {
      $result.title.addAll(title);
    }
    if (description != null) {
      $result.description.addAll(description);
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (deathAt != null) {
      $result.deathAt = deathAt;
    }
    return $result;
  }
  NotificationApp._() : super();
  factory NotificationApp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotificationApp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotificationApp', package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'title', entryClassName: 'NotificationApp.TitleEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('notifications'))
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'description', entryClassName: 'NotificationApp.DescriptionEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('notifications'))
    ..e<NotificationStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: NotificationStatus.UNREAD, valueOf: NotificationStatus.valueOf, enumValues: NotificationStatus.values)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'deathAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotificationApp clone() => NotificationApp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotificationApp copyWith(void Function(NotificationApp) updates) => super.copyWith((message) => updates(message as NotificationApp)) as NotificationApp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationApp create() => NotificationApp._();
  NotificationApp createEmptyInstance() => create();
  static $pb.PbList<NotificationApp> createRepeated() => $pb.PbList<NotificationApp>();
  @$core.pragma('dart2js:noInline')
  static NotificationApp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotificationApp>(create);
  static NotificationApp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get title => $_getMap(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get description => $_getMap(3);

  @$pb.TagNumber(5)
  NotificationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(NotificationStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $0.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($0.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureCreatedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.Timestamp get deathAt => $_getN(6);
  @$pb.TagNumber(7)
  set deathAt($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeathAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeathAt() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureDeathAt() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
