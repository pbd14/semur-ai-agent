//
//  Generated code. Do not modify.
//  source: external_apps/external_app.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use externalAppTypeDescriptor instead')
const ExternalAppType$json = {
  '1': 'ExternalAppType',
  '2': [
    {'1': 'TELEGRAM_BOT', '2': 0},
  ],
};

/// Descriptor for `ExternalAppType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List externalAppTypeDescriptor = $convert.base64Decode(
    'Cg9FeHRlcm5hbEFwcFR5cGUSEAoMVEVMRUdSQU1fQk9UEAA=');

@$core.Deprecated('Use externalAppIntegrationStatusDescriptor instead')
const ExternalAppIntegrationStatus$json = {
  '1': 'ExternalAppIntegrationStatus',
  '2': [
    {'1': 'INACTIVE', '2': 0},
    {'1': 'ACTIVE', '2': 1},
    {'1': 'DELETED', '2': 2},
  ],
};

/// Descriptor for `ExternalAppIntegrationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List externalAppIntegrationStatusDescriptor = $convert.base64Decode(
    'ChxFeHRlcm5hbEFwcEludGVncmF0aW9uU3RhdHVzEgwKCElOQUNUSVZFEAASCgoGQUNUSVZFEA'
    'ESCwoHREVMRVRFRBAC');

@$core.Deprecated('Use externalAppIntegrationDescriptor instead')
const ExternalAppIntegration$json = {
  '1': 'ExternalAppIntegration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.external_apps.ExternalAppType', '10': 'type'},
    {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.external_apps.ExternalAppIntegration.MetadataEntry', '10': 'metadata'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.external_apps.ExternalAppIntegrationStatus', '10': 'status'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '3': [ExternalAppIntegration_MetadataEntry$json],
};

@$core.Deprecated('Use externalAppIntegrationDescriptor instead')
const ExternalAppIntegration_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ExternalAppIntegration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalAppIntegrationDescriptor = $convert.base64Decode(
    'ChZFeHRlcm5hbEFwcEludGVncmF0aW9uEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSMgoEdHlwZRgDIAEoDjIeLmV4dGVybmFsX2FwcHMuRXh0ZXJuYWxBcHBUeXBl'
    'UgR0eXBlEk8KCG1ldGFkYXRhGAQgAygLMjMuZXh0ZXJuYWxfYXBwcy5FeHRlcm5hbEFwcEludG'
    'VncmF0aW9uLk1ldGFkYXRhRW50cnlSCG1ldGFkYXRhEkMKBnN0YXR1cxgFIAEoDjIrLmV4dGVy'
    'bmFsX2FwcHMuRXh0ZXJuYWxBcHBJbnRlZ3JhdGlvblN0YXR1c1IGc3RhdHVzEjkKCmNyZWF0ZW'
    'RfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBk'
    'YXRlZF9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBo7Cg'
    '1NZXRhZGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToC'
    'OAE=');

