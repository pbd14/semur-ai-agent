//
//  Generated code. Do not modify.
//  source: semur-engine/syncs-engine/sync_engine_outlook-mail.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncOutlookMailEmailsRequestDescriptor instead')
const SyncOutlookMailEmailsRequest$json = {
  '1': 'SyncOutlookMailEmailsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'integration_id', '3': 2, '4': 1, '5': 9, '10': 'integrationId'},
  ],
};

/// Descriptor for `SyncOutlookMailEmailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncOutlookMailEmailsRequestDescriptor = $convert.base64Decode(
    'ChxTeW5jT3V0bG9va01haWxFbWFpbHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IlCg5pbnRlZ3JhdGlvbl9pZBgCIAEoCVINaW50ZWdyYXRpb25JZA==');

@$core.Deprecated('Use syncOutlookMailEmailsFromNangoToFirestoreRequestDescriptor instead')
const SyncOutlookMailEmailsFromNangoToFirestoreRequest$json = {
  '1': 'SyncOutlookMailEmailsFromNangoToFirestoreRequest',
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

/// Descriptor for `SyncOutlookMailEmailsFromNangoToFirestoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncOutlookMailEmailsFromNangoToFirestoreRequestDescriptor = $convert.base64Decode(
    'CjBTeW5jT3V0bG9va01haWxFbWFpbHNGcm9tTmFuZ29Ub0ZpcmVzdG9yZVJlcXVlc3QSFwoHdX'
    'Nlcl9pZBgBIAEoCVIGdXNlcklkEiUKDmludGVncmF0aW9uX2lkGAIgASgJUg1pbnRlZ3JhdGlv'
    'bklkEhkKBWxpbWl0GAMgASgFSABSBWxpbWl0iAEBEjAKBmZpbHRlchgEIAMoDjIYLnN5bmNzX2'
    'VuZ2luZS5TeW5jRmlsdGVyUgZmaWx0ZXJCCAoGX2xpbWl0');

@$core.Deprecated('Use syncOutlookMailEmailsFromNangoToFirestoreResponseDescriptor instead')
const SyncOutlookMailEmailsFromNangoToFirestoreResponse$json = {
  '1': 'SyncOutlookMailEmailsFromNangoToFirestoreResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncOutlookMailEmailsFromNangoToFirestoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncOutlookMailEmailsFromNangoToFirestoreResponseDescriptor = $convert.base64Decode(
    'CjFTeW5jT3V0bG9va01haWxFbWFpbHNGcm9tTmFuZ29Ub0ZpcmVzdG9yZVJlc3BvbnNlEjgKBW'
    'Vycm9yGAEgASgOMiIuc2VtdXJfZW5naW5lLlNlbXVyRW5naW5lRXJyb3JDb2RlUgVlcnJvchIY'
    'CgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

