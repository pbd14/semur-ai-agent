//
//  Generated code. Do not modify.
//  source: external_apps/telegram_bot_integration.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use telegramBotIntegrationStatusDescriptor instead')
const TelegramBotIntegrationStatus$json = {
  '1': 'TelegramBotIntegrationStatus',
  '2': [
    {'1': 'TELEGRAM_BOT_INACTIVE', '2': 0},
    {'1': 'TELEGRAM_BOT_ACTIVE', '2': 1},
    {'1': 'TELEGRAM_BOT_DELETED', '2': 2},
  ],
};

/// Descriptor for `TelegramBotIntegrationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List telegramBotIntegrationStatusDescriptor = $convert.base64Decode(
    'ChxUZWxlZ3JhbUJvdEludGVncmF0aW9uU3RhdHVzEhkKFVRFTEVHUkFNX0JPVF9JTkFDVElWRR'
    'AAEhcKE1RFTEVHUkFNX0JPVF9BQ1RJVkUQARIYChRURUxFR1JBTV9CT1RfREVMRVRFRBAC');

@$core.Deprecated('Use telegramBotIntegrationDescriptor instead')
const TelegramBotIntegration$json = {
  '1': 'TelegramBotIntegration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_first_name', '3': 4, '4': 1, '5': 9, '10': 'userFirstName'},
    {'1': 'user_last_name', '3': 5, '4': 1, '5': 9, '10': 'userLastName'},
    {'1': 'integration_status', '3': 6, '4': 1, '5': 14, '6': '.external_apps.TelegramBotIntegrationStatus', '10': 'integrationStatus'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TelegramBotIntegration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List telegramBotIntegrationDescriptor = $convert.base64Decode(
    'ChZUZWxlZ3JhbUJvdEludGVncmF0aW9uEg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIA'
    'EoCVIIdXNlcm5hbWUSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEiYKD3VzZXJfZmlyc3RfbmFt'
    'ZRgEIAEoCVINdXNlckZpcnN0TmFtZRIkCg51c2VyX2xhc3RfbmFtZRgFIAEoCVIMdXNlckxhc3'
    'ROYW1lEloKEmludGVncmF0aW9uX3N0YXR1cxgGIAEoDjIrLmV4dGVybmFsX2FwcHMuVGVsZWdy'
    'YW1Cb3RJbnRlZ3JhdGlvblN0YXR1c1IRaW50ZWdyYXRpb25TdGF0dXMSOQoKY3JlYXRlZF9hdB'
    'gHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

