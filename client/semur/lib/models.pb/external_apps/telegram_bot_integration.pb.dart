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

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'telegram_bot_integration.pbenum.dart';

export 'telegram_bot_integration.pbenum.dart';

class TelegramBotIntegration extends $pb.GeneratedMessage {
  factory TelegramBotIntegration({
    $core.String? id,
    $core.String? username,
    $core.String? userId,
    $core.String? userFirstName,
    $core.String? userLastName,
    TelegramBotIntegrationStatus? integrationStatus,
    $0.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (username != null) {
      $result.username = username;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (userFirstName != null) {
      $result.userFirstName = userFirstName;
    }
    if (userLastName != null) {
      $result.userLastName = userLastName;
    }
    if (integrationStatus != null) {
      $result.integrationStatus = integrationStatus;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  TelegramBotIntegration._() : super();
  factory TelegramBotIntegration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TelegramBotIntegration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TelegramBotIntegration', package: const $pb.PackageName(_omitMessageNames ? '' : 'external_apps'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'userFirstName')
    ..aOS(5, _omitFieldNames ? '' : 'userLastName')
    ..e<TelegramBotIntegrationStatus>(6, _omitFieldNames ? '' : 'integrationStatus', $pb.PbFieldType.OE, defaultOrMaker: TelegramBotIntegrationStatus.TELEGRAM_BOT_INACTIVE, valueOf: TelegramBotIntegrationStatus.valueOf, enumValues: TelegramBotIntegrationStatus.values)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TelegramBotIntegration clone() => TelegramBotIntegration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TelegramBotIntegration copyWith(void Function(TelegramBotIntegration) updates) => super.copyWith((message) => updates(message as TelegramBotIntegration)) as TelegramBotIntegration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TelegramBotIntegration create() => TelegramBotIntegration._();
  TelegramBotIntegration createEmptyInstance() => create();
  static $pb.PbList<TelegramBotIntegration> createRepeated() => $pb.PbList<TelegramBotIntegration>();
  @$core.pragma('dart2js:noInline')
  static TelegramBotIntegration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TelegramBotIntegration>(create);
  static TelegramBotIntegration? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userFirstName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userFirstName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserFirstName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserFirstName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get userLastName => $_getSZ(4);
  @$pb.TagNumber(5)
  set userLastName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUserLastName() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserLastName() => clearField(5);

  @$pb.TagNumber(6)
  TelegramBotIntegrationStatus get integrationStatus => $_getN(5);
  @$pb.TagNumber(6)
  set integrationStatus(TelegramBotIntegrationStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasIntegrationStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearIntegrationStatus() => clearField(6);

  @$pb.TagNumber(7)
  $0.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureCreatedAt() => $_ensure(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
