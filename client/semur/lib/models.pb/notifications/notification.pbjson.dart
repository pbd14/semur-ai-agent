//
//  Generated code. Do not modify.
//  source: notifications/notification.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use notificationStatusDescriptor instead')
const NotificationStatus$json = {
  '1': 'NotificationStatus',
  '2': [
    {'1': 'UNREAD', '2': 0},
    {'1': 'READ', '2': 1},
  ],
};

/// Descriptor for `NotificationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List notificationStatusDescriptor = $convert.base64Decode(
    'ChJOb3RpZmljYXRpb25TdGF0dXMSCgoGVU5SRUFEEAASCAoEUkVBRBAB');

@$core.Deprecated('Use notificationAppDescriptor instead')
const NotificationApp$json = {
  '1': 'NotificationApp',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'title', '3': 3, '4': 3, '5': 11, '6': '.notifications.NotificationApp.TitleEntry', '10': 'title'},
    {'1': 'description', '3': 4, '4': 3, '5': 11, '6': '.notifications.NotificationApp.DescriptionEntry', '10': 'description'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.notifications.NotificationStatus', '10': 'status'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'death_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deathAt'},
  ],
  '3': [NotificationApp_TitleEntry$json, NotificationApp_DescriptionEntry$json],
};

@$core.Deprecated('Use notificationAppDescriptor instead')
const NotificationApp_TitleEntry$json = {
  '1': 'TitleEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use notificationAppDescriptor instead')
const NotificationApp_DescriptionEntry$json = {
  '1': 'DescriptionEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NotificationApp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationAppDescriptor = $convert.base64Decode(
    'Cg9Ob3RpZmljYXRpb25BcHASDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBI/CgV0aXRsZRgDIAMoCzIpLm5vdGlmaWNhdGlvbnMuTm90aWZpY2F0aW9uQXBwLlRpdGxl'
    'RW50cnlSBXRpdGxlElEKC2Rlc2NyaXB0aW9uGAQgAygLMi8ubm90aWZpY2F0aW9ucy5Ob3RpZm'
    'ljYXRpb25BcHAuRGVzY3JpcHRpb25FbnRyeVILZGVzY3JpcHRpb24SOQoGc3RhdHVzGAUgASgO'
    'MiEubm90aWZpY2F0aW9ucy5Ob3RpZmljYXRpb25TdGF0dXNSBnN0YXR1cxI5CgpjcmVhdGVkX2'
    'F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjUKCGRlYXRo'
    'X2F0GAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZGVhdGhBdBo4CgpUaXRsZU'
    'VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEaPgoQRGVz'
    'Y3JpcHRpb25FbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6Aj'
    'gB');

