//
//  Generated code. Do not modify.
//  source: semur-engine/nango-engine/nango_engine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use nangoUserConnectionsRequestDescriptor instead')
const NangoUserConnectionsRequest$json = {
  '1': 'NangoUserConnectionsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'organization_id', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'organizationId', '17': true},
  ],
  '8': [
    {'1': '_organization_id'},
  ],
};

/// Descriptor for `NangoUserConnectionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoUserConnectionsRequestDescriptor = $convert.base64Decode(
    'ChtOYW5nb1VzZXJDb25uZWN0aW9uc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEi'
    'wKD29yZ2FuaXphdGlvbl9pZBgCIAEoCUgAUg5vcmdhbml6YXRpb25JZIgBAUISChBfb3JnYW5p'
    'emF0aW9uX2lk');

@$core.Deprecated('Use nangoUserConnectionsResponseDescriptor instead')
const NangoUserConnectionsResponse$json = {
  '1': 'NangoUserConnectionsResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'connections', '3': 3, '4': 3, '5': 11, '6': '.nango.NangoConnectionPublic', '10': 'connections'},
  ],
};

/// Descriptor for `NangoUserConnectionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoUserConnectionsResponseDescriptor = $convert.base64Decode(
    'ChxOYW5nb1VzZXJDb25uZWN0aW9uc1Jlc3BvbnNlEjgKBWVycm9yGAEgASgOMiIuc2VtdXJfZW'
    '5naW5lLlNlbXVyRW5naW5lRXJyb3JDb2RlUgVlcnJvchIYCgdtZXNzYWdlGAIgASgJUgdtZXNz'
    'YWdlEj4KC2Nvbm5lY3Rpb25zGAMgAygLMhwubmFuZ28uTmFuZ29Db25uZWN0aW9uUHVibGljUg'
    'tjb25uZWN0aW9ucw==');

@$core.Deprecated('Use nangoSessionTokenRequestDescriptor instead')
const NangoSessionTokenRequest$json = {
  '1': 'NangoSessionTokenRequest',
  '2': [
    {'1': 'integration_id', '3': 1, '4': 1, '5': 9, '10': 'integrationId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_email', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'userEmail', '17': true},
    {'1': 'user_name', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'userName', '17': true},
  ],
  '8': [
    {'1': '_user_email'},
    {'1': '_user_name'},
  ],
};

/// Descriptor for `NangoSessionTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoSessionTokenRequestDescriptor = $convert.base64Decode(
    'ChhOYW5nb1Nlc3Npb25Ub2tlblJlcXVlc3QSJQoOaW50ZWdyYXRpb25faWQYASABKAlSDWludG'
    'VncmF0aW9uSWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEiIKCnVzZXJfZW1haWwYAyABKAlI'
    'AFIJdXNlckVtYWlsiAEBEiAKCXVzZXJfbmFtZRgEIAEoCUgBUgh1c2VyTmFtZYgBAUINCgtfdX'
    'Nlcl9lbWFpbEIMCgpfdXNlcl9uYW1l');

@$core.Deprecated('Use nangoSessionTokenResponseDescriptor instead')
const NangoSessionTokenResponse$json = {
  '1': 'NangoSessionTokenResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `NangoSessionTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoSessionTokenResponseDescriptor = $convert.base64Decode(
    'ChlOYW5nb1Nlc3Npb25Ub2tlblJlc3BvbnNlEjgKBWVycm9yGAEgASgOMiIuc2VtdXJfZW5naW'
    '5lLlNlbXVyRW5naW5lRXJyb3JDb2RlUgVlcnJvchIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl'
    'EhQKBXRva2VuGAMgASgJUgV0b2tlbg==');

@$core.Deprecated('Use nangoConnectionWebhookEndUserDescriptor instead')
const NangoConnectionWebhookEndUser$json = {
  '1': 'NangoConnectionWebhookEndUser',
  '2': [
    {'1': 'endUserId', '3': 1, '4': 1, '5': 9, '10': 'endUserId'},
    {'1': 'organizationId', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'organizationId', '17': true},
  ],
  '8': [
    {'1': '_organizationId'},
  ],
};

/// Descriptor for `NangoConnectionWebhookEndUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionWebhookEndUserDescriptor = $convert.base64Decode(
    'Ch1OYW5nb0Nvbm5lY3Rpb25XZWJob29rRW5kVXNlchIcCgllbmRVc2VySWQYASABKAlSCWVuZF'
    'VzZXJJZBIrCg5vcmdhbml6YXRpb25JZBgCIAEoCUgAUg5vcmdhbml6YXRpb25JZIgBAUIRCg9f'
    'b3JnYW5pemF0aW9uSWQ=');

@$core.Deprecated('Use nangoConnectionWebhookErrorDescriptor instead')
const NangoConnectionWebhookError$json = {
  '1': 'NangoConnectionWebhookError',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `NangoConnectionWebhookError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionWebhookErrorDescriptor = $convert.base64Decode(
    'ChtOYW5nb0Nvbm5lY3Rpb25XZWJob29rRXJyb3ISEgoEdHlwZRgBIAEoCVIEdHlwZRIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use nangoConnectionWebhookRequestDescriptor instead')
const NangoConnectionWebhookRequest$json = {
  '1': 'NangoConnectionWebhookRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'operation', '3': 2, '4': 1, '5': 9, '10': 'operation'},
    {'1': 'connection_id', '3': 3, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'auth_mode', '3': 4, '4': 1, '5': 9, '10': 'authMode'},
    {'1': 'provider_config_key', '3': 5, '4': 1, '5': 9, '10': 'providerConfigKey'},
    {'1': 'provider', '3': 6, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'environment', '3': 7, '4': 1, '5': 9, '10': 'environment'},
    {'1': 'success', '3': 8, '4': 1, '5': 8, '10': 'success'},
    {'1': 'end_user', '3': 9, '4': 1, '5': 11, '6': '.semur_engine.NangoConnectionWebhookEndUser', '9': 0, '10': 'endUser', '17': true},
    {'1': 'error', '3': 10, '4': 1, '5': 11, '6': '.semur_engine.NangoConnectionWebhookError', '9': 1, '10': 'error', '17': true},
  ],
  '8': [
    {'1': '_end_user'},
    {'1': '_error'},
  ],
};

/// Descriptor for `NangoConnectionWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionWebhookRequestDescriptor = $convert.base64Decode(
    'Ch1OYW5nb0Nvbm5lY3Rpb25XZWJob29rUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEhwKCW'
    '9wZXJhdGlvbhgCIAEoCVIJb3BlcmF0aW9uEiMKDWNvbm5lY3Rpb25faWQYAyABKAlSDGNvbm5l'
    'Y3Rpb25JZBIbCglhdXRoX21vZGUYBCABKAlSCGF1dGhNb2RlEi4KE3Byb3ZpZGVyX2NvbmZpZ1'
    '9rZXkYBSABKAlSEXByb3ZpZGVyQ29uZmlnS2V5EhoKCHByb3ZpZGVyGAYgASgJUghwcm92aWRl'
    'chIgCgtlbnZpcm9ubWVudBgHIAEoCVILZW52aXJvbm1lbnQSGAoHc3VjY2VzcxgIIAEoCFIHc3'
    'VjY2VzcxJLCghlbmRfdXNlchgJIAEoCzIrLnNlbXVyX2VuZ2luZS5OYW5nb0Nvbm5lY3Rpb25X'
    'ZWJob29rRW5kVXNlckgAUgdlbmRVc2VyiAEBEkQKBWVycm9yGAogASgLMikuc2VtdXJfZW5naW'
    '5lLk5hbmdvQ29ubmVjdGlvbldlYmhvb2tFcnJvckgBUgVlcnJvcogBAUILCglfZW5kX3VzZXJC'
    'CAoGX2Vycm9y');

@$core.Deprecated('Use nangoSyncWebhookRequestDescriptor instead')
const NangoSyncWebhookRequest$json = {
  '1': 'NangoSyncWebhookRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'connection_id', '3': 2, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'provider_config_key', '3': 3, '4': 1, '5': 9, '10': 'providerConfigKey'},
    {'1': 'sync_name', '3': 4, '4': 1, '5': 9, '10': 'syncName'},
    {'1': 'model', '3': 5, '4': 1, '5': 9, '10': 'model'},
    {'1': 'sync_type', '3': 6, '4': 1, '5': 9, '10': 'syncType'},
    {'1': 'success', '3': 7, '4': 1, '5': 8, '10': 'success'},
    {'1': 'modified_after', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'modifiedAfter'},
    {'1': 'response_results', '3': 9, '4': 1, '5': 11, '6': '.semur_engine.NangoSyncWebhookResponseResults', '10': 'responseResults'},
  ],
};

/// Descriptor for `NangoSyncWebhookRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoSyncWebhookRequestDescriptor = $convert.base64Decode(
    'ChdOYW5nb1N5bmNXZWJob29rUmVxdWVzdBISCgR0eXBlGAEgASgJUgR0eXBlEiMKDWNvbm5lY3'
    'Rpb25faWQYAiABKAlSDGNvbm5lY3Rpb25JZBIuChNwcm92aWRlcl9jb25maWdfa2V5GAMgASgJ'
    'UhFwcm92aWRlckNvbmZpZ0tleRIbCglzeW5jX25hbWUYBCABKAlSCHN5bmNOYW1lEhQKBW1vZG'
    'VsGAUgASgJUgVtb2RlbBIbCglzeW5jX3R5cGUYBiABKAlSCHN5bmNUeXBlEhgKB3N1Y2Nlc3MY'
    'ByABKAhSB3N1Y2Nlc3MSQQoObW9kaWZpZWRfYWZ0ZXIYCCABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUg1tb2RpZmllZEFmdGVyElgKEHJlc3BvbnNlX3Jlc3VsdHMYCSABKAsyLS5z'
    'ZW11cl9lbmdpbmUuTmFuZ29TeW5jV2ViaG9va1Jlc3BvbnNlUmVzdWx0c1IPcmVzcG9uc2VSZX'
    'N1bHRz');

@$core.Deprecated('Use nangoSyncWebhookResponseResultsDescriptor instead')
const NangoSyncWebhookResponseResults$json = {
  '1': 'NangoSyncWebhookResponseResults',
  '2': [
    {'1': 'added', '3': 1, '4': 1, '5': 5, '10': 'added'},
    {'1': 'updated', '3': 2, '4': 1, '5': 5, '10': 'updated'},
    {'1': 'deleted', '3': 3, '4': 1, '5': 5, '10': 'deleted'},
  ],
};

/// Descriptor for `NangoSyncWebhookResponseResults`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoSyncWebhookResponseResultsDescriptor = $convert.base64Decode(
    'Ch9OYW5nb1N5bmNXZWJob29rUmVzcG9uc2VSZXN1bHRzEhQKBWFkZGVkGAEgASgFUgVhZGRlZB'
    'IYCgd1cGRhdGVkGAIgASgFUgd1cGRhdGVkEhgKB2RlbGV0ZWQYAyABKAVSB2RlbGV0ZWQ=');

@$core.Deprecated('Use nangoTriggerSyncRequestDescriptor instead')
const NangoTriggerSyncRequest$json = {
  '1': 'NangoTriggerSyncRequest',
  '2': [
    {'1': 'provider_config_key', '3': 1, '4': 1, '5': 9, '10': 'providerConfigKey'},
    {'1': 'syncs', '3': 2, '4': 3, '5': 9, '10': 'syncs'},
    {'1': 'connection_id', '3': 3, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'sync_mode', '3': 4, '4': 1, '5': 14, '6': '.syncs.SyncMode', '10': 'syncMode'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `NangoTriggerSyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoTriggerSyncRequestDescriptor = $convert.base64Decode(
    'ChdOYW5nb1RyaWdnZXJTeW5jUmVxdWVzdBIuChNwcm92aWRlcl9jb25maWdfa2V5GAEgASgJUh'
    'Fwcm92aWRlckNvbmZpZ0tleRIUCgVzeW5jcxgCIAMoCVIFc3luY3MSIwoNY29ubmVjdGlvbl9p'
    'ZBgDIAEoCVIMY29ubmVjdGlvbklkEiwKCXN5bmNfbW9kZRgEIAEoDjIPLnN5bmNzLlN5bmNNb2'
    'RlUghzeW5jTW9kZRIXCgd1c2VyX2lkGAUgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use nangoTriggerSyncResponseDescriptor instead')
const NangoTriggerSyncResponse$json = {
  '1': 'NangoTriggerSyncResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `NangoTriggerSyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoTriggerSyncResponseDescriptor = $convert.base64Decode(
    'ChhOYW5nb1RyaWdnZXJTeW5jUmVzcG9uc2USOAoFZXJyb3IYASABKA4yIi5zZW11cl9lbmdpbm'
    'UuU2VtdXJFbmdpbmVFcnJvckNvZGVSBWVycm9yEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2U=');

