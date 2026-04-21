//
//  Generated code. Do not modify.
//  source: general.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PhotoFirebase extends $pb.GeneratedMessage {
  factory PhotoFirebase({
    $core.String? photo,
    $core.String? photoRef,
  }) {
    final $result = create();
    if (photo != null) {
      $result.photo = photo;
    }
    if (photoRef != null) {
      $result.photoRef = photoRef;
    }
    return $result;
  }
  PhotoFirebase._() : super();
  factory PhotoFirebase.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PhotoFirebase.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PhotoFirebase', package: const $pb.PackageName(_omitMessageNames ? '' : 'general'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'photo')
    ..aOS(2, _omitFieldNames ? '' : 'photoRef')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PhotoFirebase clone() => PhotoFirebase()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PhotoFirebase copyWith(void Function(PhotoFirebase) updates) => super.copyWith((message) => updates(message as PhotoFirebase)) as PhotoFirebase;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PhotoFirebase create() => PhotoFirebase._();
  PhotoFirebase createEmptyInstance() => create();
  static $pb.PbList<PhotoFirebase> createRepeated() => $pb.PbList<PhotoFirebase>();
  @$core.pragma('dart2js:noInline')
  static PhotoFirebase getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoFirebase>(create);
  static PhotoFirebase? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get photo => $_getSZ(0);
  @$pb.TagNumber(1)
  set photo($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhoto() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoto() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get photoRef => $_getSZ(1);
  @$pb.TagNumber(2)
  set photoRef($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPhotoRef() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhotoRef() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
