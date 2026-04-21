//
//  Generated code. Do not modify.
//  source: semur-engine/syncs-engine/sync_engine_google-mail.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncGoogleMailEmailsRequestDescriptor instead')
const SyncGoogleMailEmailsRequest$json = {
  '1': 'SyncGoogleMailEmailsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'integration_id', '3': 2, '4': 1, '5': 9, '10': 'integrationId'},
  ],
};

/// Descriptor for `SyncGoogleMailEmailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleMailEmailsRequestDescriptor = $convert.base64Decode(
    'ChtTeW5jR29vZ2xlTWFpbEVtYWlsc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi'
    'UKDmludGVncmF0aW9uX2lkGAIgASgJUg1pbnRlZ3JhdGlvbklk');

@$core.Deprecated('Use syncGoogleMailEmailsFromNangoToFirestoreRequestDescriptor instead')
const SyncGoogleMailEmailsFromNangoToFirestoreRequest$json = {
  '1': 'SyncGoogleMailEmailsFromNangoToFirestoreRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'integration_id', '3': 2, '4': 1, '5': 9, '10': 'integrationId'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '9': 0, '10': 'limit', '17': true},
    {'1': 'filter', '3': 4, '4': 3, '5': 14, '6': '.syncs_engine.SyncFilter', '10': 'filter'},
  ],
  '8': [
    {'1': '_limit'},
  ],
};

/// Descriptor for `SyncGoogleMailEmailsFromNangoToFirestoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleMailEmailsFromNangoToFirestoreRequestDescriptor = $convert.base64Decode(
    'Ci9TeW5jR29vZ2xlTWFpbEVtYWlsc0Zyb21OYW5nb1RvRmlyZXN0b3JlUmVxdWVzdBIXCgd1c2'
    'VyX2lkGAEgASgJUgZ1c2VySWQSJQoOaW50ZWdyYXRpb25faWQYAiABKAlSDWludGVncmF0aW9u'
    'SWQSGQoFbGltaXQYAyABKAVIAFIFbGltaXSIAQESMAoGZmlsdGVyGAQgAygOMhguc3luY3NfZW'
    '5naW5lLlN5bmNGaWx0ZXJSBmZpbHRlckIICgZfbGltaXQ=');

@$core.Deprecated('Use syncGoogleMailEmailsFromNangoToFirestoreResponseDescriptor instead')
const SyncGoogleMailEmailsFromNangoToFirestoreResponse$json = {
  '1': 'SyncGoogleMailEmailsFromNangoToFirestoreResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncGoogleMailEmailsFromNangoToFirestoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleMailEmailsFromNangoToFirestoreResponseDescriptor = $convert.base64Decode(
    'CjBTeW5jR29vZ2xlTWFpbEVtYWlsc0Zyb21OYW5nb1RvRmlyZXN0b3JlUmVzcG9uc2USOAoFZX'
    'Jyb3IYASABKA4yIi5zZW11cl9lbmdpbmUuU2VtdXJFbmdpbmVFcnJvckNvZGVSBWVycm9yEhgK'
    'B21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

