//
//  Generated code. Do not modify.
//  source: semur-engine/semur_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use semurEngineErrorCodeDescriptor instead')
const SemurEngineErrorCode$json = {
  '1': 'SemurEngineErrorCode',
  '2': [
    {'1': 'NO_ERROR', '2': 0},
    {'1': 'CUSTOM_ERROR', '2': 100},
    {'1': 'NO_DATA_RECEIVED', '2': 101},
    {'1': 'INTERNAL_ERROR', '2': 1},
    {'1': 'BAD_REQUEST', '2': 2},
    {'1': 'UNAUTHORIZED', '2': 3},
    {'1': 'NOT_FOUND', '2': 4},
    {'1': 'METHOD_NOT_ALLOWED', '2': 5},
    {'1': 'CONFLICT', '2': 6},
    {'1': 'TOO_MANY_REQUESTS', '2': 7},
    {'1': 'UNAVAILABLE', '2': 8},
    {'1': 'PERMISSION_DENIED', '2': 9},
    {'1': 'NANGO_ERROR', '2': 10},
    {'1': 'NANGO_SESSION_TOKEN_ERROR', '2': 11},
    {'1': 'NANGO_CONNECTION_ERROR', '2': 12},
    {'1': 'AGENT_ERROR', '2': 20},
    {'1': 'AGENT_NO_INTEGRATION', '2': 21},
    {'1': 'AGENT_MODEL_ERROR', '2': 22},
  ],
};

/// Descriptor for `SemurEngineErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List semurEngineErrorCodeDescriptor = $convert.base64Decode(
    'ChRTZW11ckVuZ2luZUVycm9yQ29kZRIMCghOT19FUlJPUhAAEhAKDENVU1RPTV9FUlJPUhBkEh'
    'QKEE5PX0RBVEFfUkVDRUlWRUQQZRISCg5JTlRFUk5BTF9FUlJPUhABEg8KC0JBRF9SRVFVRVNU'
    'EAISEAoMVU5BVVRIT1JJWkVEEAMSDQoJTk9UX0ZPVU5EEAQSFgoSTUVUSE9EX05PVF9BTExPV0'
    'VEEAUSDAoIQ09ORkxJQ1QQBhIVChFUT09fTUFOWV9SRVFVRVNUUxAHEg8KC1VOQVZBSUxBQkxF'
    'EAgSFQoRUEVSTUlTU0lPTl9ERU5JRUQQCRIPCgtOQU5HT19FUlJPUhAKEh0KGU5BTkdPX1NFU1'
    'NJT05fVE9LRU5fRVJST1IQCxIaChZOQU5HT19DT05ORUNUSU9OX0VSUk9SEAwSDwoLQUdFTlRf'
    'RVJST1IQFBIYChRBR0VOVF9OT19JTlRFR1JBVElPThAVEhUKEUFHRU5UX01PREVMX0VSUk9SEB'
    'Y=');

@$core.Deprecated('Use semurEngineResponseDescriptor instead')
const SemurEngineResponse$json = {
  '1': 'SemurEngineResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SemurEngineResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List semurEngineResponseDescriptor = $convert.base64Decode(
    'ChNTZW11ckVuZ2luZVJlc3BvbnNlEjgKBWVycm9yGAEgASgOMiIuc2VtdXJfZW5naW5lLlNlbX'
    'VyRW5naW5lRXJyb3JDb2RlUgVlcnJvchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

