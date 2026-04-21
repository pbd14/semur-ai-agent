//
//  Generated code. Do not modify.
//  source: user/user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userStatusDescriptor instead')
const UserStatus$json = {
  '1': 'UserStatus',
  '2': [
    {'1': 'CREATED', '2': 0},
    {'1': 'UNVERIFIED', '2': 1},
    {'1': 'VERIFIED', '2': 2},
    {'1': 'BLOCKED', '2': 3},
  ],
};

/// Descriptor for `UserStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userStatusDescriptor = $convert.base64Decode(
    'CgpVc2VyU3RhdHVzEgsKB0NSRUFURUQQABIOCgpVTlZFUklGSUVEEAESDAoIVkVSSUZJRUQQAh'
    'ILCgdCTE9DS0VEEAM=');

@$core.Deprecated('Use semurUserDescriptor instead')
const SemurUser$json = {
  '1': 'SemurUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'email', '17': true},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'birth_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'birthDate'},
    {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.users.UserStatus', '10': 'status'},
    {'1': 'fcm_android_tokens', '3': 7, '4': 3, '5': 9, '10': 'fcmAndroidTokens'},
    {'1': 'fcm_ios_tokens', '3': 8, '4': 3, '5': 9, '10': 'fcmIosTokens'},
    {'1': 'vapid_web_tokens', '3': 9, '4': 3, '5': 9, '10': 'vapidWebTokens'},
    {'1': 'language', '3': 10, '4': 1, '5': 9, '9': 1, '10': 'language', '17': true},
    {'1': 'organization_id', '3': 11, '4': 1, '5': 9, '9': 2, '10': 'organizationId', '17': true},
    {'1': 'photo', '3': 12, '4': 1, '5': 11, '6': '.general.PhotoFirebase', '10': 'photo'},
  ],
  '8': [
    {'1': '_email'},
    {'1': '_language'},
    {'1': '_organization_id'},
  ],
};

/// Descriptor for `SemurUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List semurUserDescriptor = $convert.base64Decode(
    'CglTZW11clVzZXISDgoCaWQYASABKAlSAmlkEhkKBWVtYWlsGAIgASgJSABSBWVtYWlsiAEBEh'
    '0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUYBCABKAlSCGxhc3RO'
    'YW1lEjkKCmJpcnRoX2RhdGUYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgliaX'
    'J0aERhdGUSKQoGc3RhdHVzGAYgASgOMhEudXNlcnMuVXNlclN0YXR1c1IGc3RhdHVzEiwKEmZj'
    'bV9hbmRyb2lkX3Rva2VucxgHIAMoCVIQZmNtQW5kcm9pZFRva2VucxIkCg5mY21faW9zX3Rva2'
    'VucxgIIAMoCVIMZmNtSW9zVG9rZW5zEigKEHZhcGlkX3dlYl90b2tlbnMYCSADKAlSDnZhcGlk'
    'V2ViVG9rZW5zEh8KCGxhbmd1YWdlGAogASgJSAFSCGxhbmd1YWdliAEBEiwKD29yZ2FuaXphdG'
    'lvbl9pZBgLIAEoCUgCUg5vcmdhbml6YXRpb25JZIgBARIsCgVwaG90bxgMIAEoCzIWLmdlbmVy'
    'YWwuUGhvdG9GaXJlYmFzZVIFcGhvdG9CCAoGX2VtYWlsQgsKCV9sYW5ndWFnZUISChBfb3JnYW'
    '5pemF0aW9uX2lk');

@$core.Deprecated('Use userNotificationDescriptor instead')
const UserNotification$json = {
  '1': 'UserNotification',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'title', '3': 3, '4': 3, '5': 11, '6': '.users.UserNotification.TitleEntry', '10': 'title'},
    {'1': 'description', '3': 4, '4': 3, '5': 11, '6': '.users.UserNotification.DescriptionEntry', '10': 'description'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.notifications.NotificationStatus', '10': 'status'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'death_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deathAt'},
  ],
  '3': [UserNotification_TitleEntry$json, UserNotification_DescriptionEntry$json],
};

@$core.Deprecated('Use userNotificationDescriptor instead')
const UserNotification_TitleEntry$json = {
  '1': 'TitleEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use userNotificationDescriptor instead')
const UserNotification_DescriptionEntry$json = {
  '1': 'DescriptionEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `UserNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userNotificationDescriptor = $convert.base64Decode(
    'ChBVc2VyTm90aWZpY2F0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSOAoFdGl0bGUYAyADKAsyIi51c2Vycy5Vc2VyTm90aWZpY2F0aW9uLlRpdGxlRW50cnlS'
    'BXRpdGxlEkoKC2Rlc2NyaXB0aW9uGAQgAygLMigudXNlcnMuVXNlck5vdGlmaWNhdGlvbi5EZX'
    'NjcmlwdGlvbkVudHJ5UgtkZXNjcmlwdGlvbhI5CgZzdGF0dXMYBSABKA4yIS5ub3RpZmljYXRp'
    'b25zLk5vdGlmaWNhdGlvblN0YXR1c1IGc3RhdHVzEjkKCmNyZWF0ZWRfYXQYBiABKAsyGi5nb2'
    '9nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSNQoIZGVhdGhfYXQYByABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdkZWF0aEF0GjgKClRpdGxlRW50cnkSEAoDa2V5GA'
    'EgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4ARo+ChBEZXNjcmlwdGlvbkVudHJ5'
    'EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

