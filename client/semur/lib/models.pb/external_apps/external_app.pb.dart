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

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'external_app.pbenum.dart';

export 'external_app.pbenum.dart';

class ExternalAppIntegration extends $pb.GeneratedMessage {
  factory ExternalAppIntegration({
    $core.String? id,
    $core.String? userId,
    ExternalAppType? type,
    $core.Map<$core.String, $core.String>? metadata,
    ExternalAppIntegrationStatus? status,
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  ExternalAppIntegration._() : super();
  factory ExternalAppIntegration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExternalAppIntegration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExternalAppIntegration', package: const $pb.PackageName(_omitMessageNames ? '' : 'external_apps'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<ExternalAppType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ExternalAppType.TELEGRAM_BOT, valueOf: ExternalAppType.valueOf, enumValues: ExternalAppType.values)
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata', entryClassName: 'ExternalAppIntegration.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('external_apps'))
    ..e<ExternalAppIntegrationStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ExternalAppIntegrationStatus.INACTIVE, valueOf: ExternalAppIntegrationStatus.valueOf, enumValues: ExternalAppIntegrationStatus.values)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'updatedAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExternalAppIntegration clone() => ExternalAppIntegration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExternalAppIntegration copyWith(void Function(ExternalAppIntegration) updates) => super.copyWith((message) => updates(message as ExternalAppIntegration)) as ExternalAppIntegration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalAppIntegration create() => ExternalAppIntegration._();
  ExternalAppIntegration createEmptyInstance() => create();
  static $pb.PbList<ExternalAppIntegration> createRepeated() => $pb.PbList<ExternalAppIntegration>();
  @$core.pragma('dart2js:noInline')
  static ExternalAppIntegration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExternalAppIntegration>(create);
  static ExternalAppIntegration? _defaultInstance;

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
  ExternalAppType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(ExternalAppType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(3);

  @$pb.TagNumber(5)
  ExternalAppIntegrationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(ExternalAppIntegrationStatus v) { setField(5, v); }
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
  $0.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureUpdatedAt() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
