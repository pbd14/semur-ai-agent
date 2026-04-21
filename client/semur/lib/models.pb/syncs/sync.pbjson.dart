//
//  Generated code. Do not modify.
//  source: syncs/sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncModeDescriptor instead')
const SyncMode$json = {
  '1': 'SyncMode',
  '2': [
    {'1': 'INCREMENTAL', '2': 0},
    {'1': 'FULL_REFRESH', '2': 1},
    {'1': 'FULL_REFRESH_AND_CLEAR_CACHE', '2': 2},
  ],
};

/// Descriptor for `SyncMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List syncModeDescriptor = $convert.base64Decode(
    'CghTeW5jTW9kZRIPCgtJTkNSRU1FTlRBTBAAEhAKDEZVTExfUkVGUkVTSBABEiAKHEZVTExfUk'
    'VGUkVTSF9BTkRfQ0xFQVJfQ0FDSEUQAg==');

@$core.Deprecated('Use syncStatusDescriptor instead')
const SyncStatus$json = {
  '1': 'SyncStatus',
  '2': [
    {'1': 'PENDING', '2': 0},
    {'1': 'IN_PROGRESS', '2': 1},
    {'1': 'COMPLETED', '2': 2},
    {'1': 'FAILED', '2': 3},
    {'1': 'PARTIALLY_COMPLETED', '2': 4},
  ],
};

/// Descriptor for `SyncStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List syncStatusDescriptor = $convert.base64Decode(
    'CgpTeW5jU3RhdHVzEgsKB1BFTkRJTkcQABIPCgtJTl9QUk9HUkVTUxABEg0KCUNPTVBMRVRFRB'
    'ACEgoKBkZBSUxFRBADEhcKE1BBUlRJQUxMWV9DT01QTEVURUQQBA==');

@$core.Deprecated('Use syncInformationDescriptor instead')
const SyncInformation$json = {
  '1': 'SyncInformation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nango_integration_id', '3': 2, '4': 1, '5': 9, '10': 'nangoIntegrationId'},
    {'1': 'updated_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    {'1': 'nango_next_cursor', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'nangoNextCursor', '17': true},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.syncs.SyncStatus', '10': 'status'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'errorMessage', '17': true},
  ],
  '8': [
    {'1': '_nango_next_cursor'},
    {'1': '_error_message'},
  ],
};

/// Descriptor for `SyncInformation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncInformationDescriptor = $convert.base64Decode(
    'Cg9TeW5jSW5mb3JtYXRpb24SDgoCaWQYASABKAlSAmlkEjAKFG5hbmdvX2ludGVncmF0aW9uX2'
    'lkGAIgASgJUhJuYW5nb0ludGVncmF0aW9uSWQSOQoKdXBkYXRlZF9hdBgDIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIvChFuYW5nb19uZXh0X2N1cnNvchgEIA'
    'EoCUgAUg9uYW5nb05leHRDdXJzb3KIAQESKQoGc3RhdHVzGAUgASgOMhEuc3luY3MuU3luY1N0'
    'YXR1c1IGc3RhdHVzEigKDWVycm9yX21lc3NhZ2UYBiABKAlIAVIMZXJyb3JNZXNzYWdliAEBQh'
    'QKEl9uYW5nb19uZXh0X2N1cnNvckIQCg5fZXJyb3JfbWVzc2FnZQ==');

@$core.Deprecated('Use syncNangoMetadataDescriptor instead')
const SyncNangoMetadata$json = {
  '1': 'SyncNangoMetadata',
  '2': [
    {'1': 'deleted_at', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'deletedAt'},
    {'1': 'last_action', '3': 2, '4': 1, '5': 9, '10': 'lastAction'},
    {'1': 'first_seen_at', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'firstSeenAt'},
    {'1': 'cursor', '3': 4, '4': 1, '5': 9, '10': 'cursor'},
    {'1': 'last_modified_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastModifiedAt'},
  ],
};

/// Descriptor for `SyncNangoMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncNangoMetadataDescriptor = $convert.base64Decode(
    'ChFTeW5jTmFuZ29NZXRhZGF0YRI5CgpkZWxldGVkX2F0GAEgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIJZGVsZXRlZEF0Eh8KC2xhc3RfYWN0aW9uGAIgASgJUgpsYXN0QWN0aW9u'
    'Ej4KDWZpcnN0X3NlZW5fYXQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtmaX'
    'JzdFNlZW5BdBIWCgZjdXJzb3IYBCABKAlSBmN1cnNvchJEChBsYXN0X21vZGlmaWVkX2F0GAUg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIObGFzdE1vZGlmaWVkQXQ=');

