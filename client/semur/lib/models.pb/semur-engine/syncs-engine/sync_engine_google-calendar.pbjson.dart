//
//  Generated code. Do not modify.
//  source: semur-engine/syncs-engine/sync_engine_google-calendar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncGoogleCalendarEventsRequestDescriptor instead')
const SyncGoogleCalendarEventsRequest$json = {
  '1': 'SyncGoogleCalendarEventsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'integration_id', '3': 2, '4': 1, '5': 9, '10': 'integrationId'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventsRequestDescriptor = $convert.base64Decode(
    'Ch9TeW5jR29vZ2xlQ2FsZW5kYXJFdmVudHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZX'
    'JJZBIlCg5pbnRlZ3JhdGlvbl9pZBgCIAEoCVINaW50ZWdyYXRpb25JZA==');

@$core.Deprecated('Use syncGoogleCalendarEventsFromNangoToFirestoreRequestDescriptor instead')
const SyncGoogleCalendarEventsFromNangoToFirestoreRequest$json = {
  '1': 'SyncGoogleCalendarEventsFromNangoToFirestoreRequest',
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

/// Descriptor for `SyncGoogleCalendarEventsFromNangoToFirestoreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventsFromNangoToFirestoreRequestDescriptor = $convert.base64Decode(
    'CjNTeW5jR29vZ2xlQ2FsZW5kYXJFdmVudHNGcm9tTmFuZ29Ub0ZpcmVzdG9yZVJlcXVlc3QSFw'
    'oHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiUKDmludGVncmF0aW9uX2lkGAIgASgJUg1pbnRlZ3Jh'
    'dGlvbklkEhkKBWxpbWl0GAMgASgFSABSBWxpbWl0iAEBEjAKBmZpbHRlchgEIAMoDjIYLnN5bm'
    'NzX2VuZ2luZS5TeW5jRmlsdGVyUgZmaWx0ZXJCCAoGX2xpbWl0');

@$core.Deprecated('Use syncGoogleCalendarEventsFromNangoToFirestoreResponseDescriptor instead')
const SyncGoogleCalendarEventsFromNangoToFirestoreResponse$json = {
  '1': 'SyncGoogleCalendarEventsFromNangoToFirestoreResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEventsFromNangoToFirestoreResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventsFromNangoToFirestoreResponseDescriptor = $convert.base64Decode(
    'CjRTeW5jR29vZ2xlQ2FsZW5kYXJFdmVudHNGcm9tTmFuZ29Ub0ZpcmVzdG9yZVJlc3BvbnNlEj'
    'gKBWVycm9yGAEgASgOMiIuc2VtdXJfZW5naW5lLlNlbXVyRW5naW5lRXJyb3JDb2RlUgVlcnJv'
    'chIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

