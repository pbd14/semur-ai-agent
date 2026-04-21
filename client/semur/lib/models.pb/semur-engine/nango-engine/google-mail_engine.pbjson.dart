//
//  Generated code. Do not modify.
//  source: semur-engine/nango-engine/google-mail_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use nangoGoogleMailSendEmailRequestDescriptor instead')
const NangoGoogleMailSendEmailRequest$json = {
  '1': 'NangoGoogleMailSendEmailRequest',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'to', '3': 2, '4': 1, '5': 9, '10': 'to'},
    {'1': 'headers', '3': 3, '4': 3, '5': 11, '6': '.semur_engine.NangoGoogleMailSendEmailRequest.HeadersEntry', '10': 'headers'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'subject', '17': true},
    {'1': 'body', '3': 5, '4': 1, '5': 9, '10': 'body'},
  ],
  '3': [NangoGoogleMailSendEmailRequest_HeadersEntry$json],
  '8': [
    {'1': '_subject'},
  ],
};

@$core.Deprecated('Use nangoGoogleMailSendEmailRequestDescriptor instead')
const NangoGoogleMailSendEmailRequest_HeadersEntry$json = {
  '1': 'HeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NangoGoogleMailSendEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoGoogleMailSendEmailRequestDescriptor = $convert.base64Decode(
    'Ch9OYW5nb0dvb2dsZU1haWxTZW5kRW1haWxSZXF1ZXN0EhYKBnVzZXJJZBgBIAEoCVIGdXNlck'
    'lkEg4KAnRvGAIgASgJUgJ0bxJUCgdoZWFkZXJzGAMgAygLMjouc2VtdXJfZW5naW5lLk5hbmdv'
    'R29vZ2xlTWFpbFNlbmRFbWFpbFJlcXVlc3QuSGVhZGVyc0VudHJ5UgdoZWFkZXJzEh0KB3N1Ym'
    'plY3QYBCABKAlIAFIHc3ViamVjdIgBARISCgRib2R5GAUgASgJUgRib2R5GjoKDEhlYWRlcnNF'
    'bnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBQgoKCF9zdW'
    'JqZWN0');

@$core.Deprecated('Use nangoGoogleMailSendEmailResponseDescriptor instead')
const NangoGoogleMailSendEmailResponse$json = {
  '1': 'NangoGoogleMailSendEmailResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `NangoGoogleMailSendEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoGoogleMailSendEmailResponseDescriptor = $convert.base64Decode(
    'CiBOYW5nb0dvb2dsZU1haWxTZW5kRW1haWxSZXNwb25zZRI4CgVlcnJvchgBIAEoDjIiLnNlbX'
    'VyX2VuZ2luZS5TZW11ckVuZ2luZUVycm9yQ29kZVIFZXJyb3ISGAoHbWVzc2FnZRgCIAEoCVIH'
    'bWVzc2FnZQ==');

