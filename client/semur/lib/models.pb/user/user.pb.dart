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

import '../general.pb.dart' as $6;
import '../google/protobuf/timestamp.pb.dart' as $0;
import '../notifications/notification.pbenum.dart' as $7;
import 'user.pbenum.dart';

export 'user.pbenum.dart';

class SemurUser extends $pb.GeneratedMessage {
  factory SemurUser({
    $core.String? id,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $0.Timestamp? birthDate,
    UserStatus? status,
    $core.Iterable<$core.String>? fcmAndroidTokens,
    $core.Iterable<$core.String>? fcmIosTokens,
    $core.Iterable<$core.String>? vapidWebTokens,
    $core.String? language,
    $core.String? organizationId,
    $6.PhotoFirebase? photo,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (email != null) {
      $result.email = email;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (birthDate != null) {
      $result.birthDate = birthDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (fcmAndroidTokens != null) {
      $result.fcmAndroidTokens.addAll(fcmAndroidTokens);
    }
    if (fcmIosTokens != null) {
      $result.fcmIosTokens.addAll(fcmIosTokens);
    }
    if (vapidWebTokens != null) {
      $result.vapidWebTokens.addAll(vapidWebTokens);
    }
    if (language != null) {
      $result.language = language;
    }
    if (organizationId != null) {
      $result.organizationId = organizationId;
    }
    if (photo != null) {
      $result.photo = photo;
    }
    return $result;
  }
  SemurUser._() : super();
  factory SemurUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SemurUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SemurUser', package: const $pb.PackageName(_omitMessageNames ? '' : 'users'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'birthDate', subBuilder: $0.Timestamp.create)
    ..e<UserStatus>(6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: UserStatus.CREATED, valueOf: UserStatus.valueOf, enumValues: UserStatus.values)
    ..pPS(7, _omitFieldNames ? '' : 'fcmAndroidTokens')
    ..pPS(8, _omitFieldNames ? '' : 'fcmIosTokens')
    ..pPS(9, _omitFieldNames ? '' : 'vapidWebTokens')
    ..aOS(10, _omitFieldNames ? '' : 'language')
    ..aOS(11, _omitFieldNames ? '' : 'organizationId')
    ..aOM<$6.PhotoFirebase>(12, _omitFieldNames ? '' : 'photo', subBuilder: $6.PhotoFirebase.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SemurUser clone() => SemurUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SemurUser copyWith(void Function(SemurUser) updates) => super.copyWith((message) => updates(message as SemurUser)) as SemurUser;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SemurUser create() => SemurUser._();
  SemurUser createEmptyInstance() => create();
  static $pb.PbList<SemurUser> createRepeated() => $pb.PbList<SemurUser>();
  @$core.pragma('dart2js:noInline')
  static SemurUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SemurUser>(create);
  static SemurUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get birthDate => $_getN(4);
  @$pb.TagNumber(5)
  set birthDate($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBirthDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearBirthDate() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureBirthDate() => $_ensure(4);

  @$pb.TagNumber(6)
  UserStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(UserStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get fcmAndroidTokens => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.String> get fcmIosTokens => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<$core.String> get vapidWebTokens => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get language => $_getSZ(9);
  @$pb.TagNumber(10)
  set language($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLanguage() => $_has(9);
  @$pb.TagNumber(10)
  void clearLanguage() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get organizationId => $_getSZ(10);
  @$pb.TagNumber(11)
  set organizationId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasOrganizationId() => $_has(10);
  @$pb.TagNumber(11)
  void clearOrganizationId() => clearField(11);

  @$pb.TagNumber(12)
  $6.PhotoFirebase get photo => $_getN(11);
  @$pb.TagNumber(12)
  set photo($6.PhotoFirebase v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPhoto() => $_has(11);
  @$pb.TagNumber(12)
  void clearPhoto() => clearField(12);
  @$pb.TagNumber(12)
  $6.PhotoFirebase ensurePhoto() => $_ensure(11);
}

class UserNotification extends $pb.GeneratedMessage {
  factory UserNotification({
    $core.String? id,
    $core.String? userId,
    $core.Map<$core.String, $core.String>? title,
    $core.Map<$core.String, $core.String>? description,
    $7.NotificationStatus? status,
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
  UserNotification._() : super();
  factory UserNotification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserNotification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserNotification', package: const $pb.PackageName(_omitMessageNames ? '' : 'users'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'title', entryClassName: 'UserNotification.TitleEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('users'))
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'description', entryClassName: 'UserNotification.DescriptionEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('users'))
    ..e<$7.NotificationStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $7.NotificationStatus.UNREAD, valueOf: $7.NotificationStatus.valueOf, enumValues: $7.NotificationStatus.values)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'deathAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserNotification clone() => UserNotification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserNotification copyWith(void Function(UserNotification) updates) => super.copyWith((message) => updates(message as UserNotification)) as UserNotification;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserNotification create() => UserNotification._();
  UserNotification createEmptyInstance() => create();
  static $pb.PbList<UserNotification> createRepeated() => $pb.PbList<UserNotification>();
  @$core.pragma('dart2js:noInline')
  static UserNotification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserNotification>(create);
  static UserNotification? _defaultInstance;

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
  $7.NotificationStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($7.NotificationStatus v) { setField(5, v); }
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
