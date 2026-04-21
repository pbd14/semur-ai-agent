//
//  Generated code. Do not modify.
//  source: syncs/sync_google-mail.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncGoogleMailEmailDescriptor instead')
const SyncGoogleMailEmail$json = {
  '1': 'SyncGoogleMailEmail',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'sender', '3': 2, '4': 1, '5': 9, '10': 'sender'},
    {'1': 'recipients', '3': 3, '4': 1, '5': 9, '10': 'recipients'},
    {'1': 'date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    {'1': 'subject', '3': 5, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'full_content', '3': 7, '4': 1, '5': 9, '10': 'fullContent'},
    {'1': 'attachments', '3': 8, '4': 3, '5': 11, '6': '.syncs.SyncGoogleMailEmailAttachment', '10': 'attachments'},
    {'1': 'threadId', '3': 9, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'nango_metadata', '3': 10, '4': 1, '5': 11, '6': '.syncs.SyncNangoMetadata', '10': 'nangoMetadata'},
  ],
};

/// Descriptor for `SyncGoogleMailEmail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleMailEmailDescriptor = $convert.base64Decode(
    'ChNTeW5jR29vZ2xlTWFpbEVtYWlsEg4KAmlkGAEgASgJUgJpZBIWCgZzZW5kZXIYAiABKAlSBn'
    'NlbmRlchIeCgpyZWNpcGllbnRzGAMgASgJUgpyZWNpcGllbnRzEi4KBGRhdGUYBCABKAsyGi5n'
    'b29nbGUucHJvdG9idWYuVGltZXN0YW1wUgRkYXRlEhgKB3N1YmplY3QYBSABKAlSB3N1YmplY3'
    'QSEgoEYm9keRgGIAEoCVIEYm9keRIhCgxmdWxsX2NvbnRlbnQYByABKAlSC2Z1bGxDb250ZW50'
    'EkYKC2F0dGFjaG1lbnRzGAggAygLMiQuc3luY3MuU3luY0dvb2dsZU1haWxFbWFpbEF0dGFjaG'
    '1lbnRSC2F0dGFjaG1lbnRzEhoKCHRocmVhZElkGAkgASgJUgh0aHJlYWRJZBI/Cg5uYW5nb19t'
    'ZXRhZGF0YRgKIAEoCzIYLnN5bmNzLlN5bmNOYW5nb01ldGFkYXRhUg1uYW5nb01ldGFkYXRh');

@$core.Deprecated('Use syncGoogleMailEmailAttachmentDescriptor instead')
const SyncGoogleMailEmailAttachment$json = {
  '1': 'SyncGoogleMailEmailAttachment',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'mimeType', '3': 2, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'size', '3': 3, '4': 1, '5': 5, '10': 'size'},
    {'1': 'attachmentId', '3': 4, '4': 1, '5': 9, '10': 'attachmentId'},
  ],
};

/// Descriptor for `SyncGoogleMailEmailAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleMailEmailAttachmentDescriptor = $convert.base64Decode(
    'Ch1TeW5jR29vZ2xlTWFpbEVtYWlsQXR0YWNobWVudBIaCghmaWxlbmFtZRgBIAEoCVIIZmlsZW'
    '5hbWUSGgoIbWltZVR5cGUYAiABKAlSCG1pbWVUeXBlEhIKBHNpemUYAyABKAVSBHNpemUSIgoM'
    'YXR0YWNobWVudElkGAQgASgJUgxhdHRhY2htZW50SWQ=');

