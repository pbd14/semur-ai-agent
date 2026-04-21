//
//  Generated code. Do not modify.
//  source: syncs/sync_outlook.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncOutlookEmailDescriptor instead')
const SyncOutlookEmail$json = {
  '1': 'SyncOutlookEmail',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'sender', '3': 2, '4': 1, '5': 9, '10': 'sender'},
    {'1': 'recipients', '3': 3, '4': 1, '5': 9, '10': 'recipients'},
    {'1': 'date', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
    {'1': 'subject', '3': 5, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'body', '3': 6, '4': 1, '5': 9, '10': 'body'},
    {'1': 'full_content', '3': 7, '4': 1, '5': 9, '10': 'fullContent'},
    {'1': 'attachments', '3': 8, '4': 3, '5': 11, '6': '.syncs.SyncOutlookEmailAttachment', '10': 'attachments'},
    {'1': 'threadId', '3': 9, '4': 1, '5': 9, '10': 'threadId'},
    {'1': 'nango_metadata', '3': 10, '4': 1, '5': 11, '6': '.syncs.SyncNangoMetadata', '10': 'nangoMetadata'},
  ],
};

/// Descriptor for `SyncOutlookEmail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncOutlookEmailDescriptor = $convert.base64Decode(
    'ChBTeW5jT3V0bG9va0VtYWlsEg4KAmlkGAEgASgJUgJpZBIWCgZzZW5kZXIYAiABKAlSBnNlbm'
    'RlchIeCgpyZWNpcGllbnRzGAMgASgJUgpyZWNpcGllbnRzEi4KBGRhdGUYBCABKAsyGi5nb29n'
    'bGUucHJvdG9idWYuVGltZXN0YW1wUgRkYXRlEhgKB3N1YmplY3QYBSABKAlSB3N1YmplY3QSEg'
    'oEYm9keRgGIAEoCVIEYm9keRIhCgxmdWxsX2NvbnRlbnQYByABKAlSC2Z1bGxDb250ZW50EkMK'
    'C2F0dGFjaG1lbnRzGAggAygLMiEuc3luY3MuU3luY091dGxvb2tFbWFpbEF0dGFjaG1lbnRSC2'
    'F0dGFjaG1lbnRzEhoKCHRocmVhZElkGAkgASgJUgh0aHJlYWRJZBI/Cg5uYW5nb19tZXRhZGF0'
    'YRgKIAEoCzIYLnN5bmNzLlN5bmNOYW5nb01ldGFkYXRhUg1uYW5nb01ldGFkYXRh');

@$core.Deprecated('Use syncOutlookEmailAttachmentDescriptor instead')
const SyncOutlookEmailAttachment$json = {
  '1': 'SyncOutlookEmailAttachment',
  '2': [
    {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
    {'1': 'mimeType', '3': 2, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'size', '3': 3, '4': 1, '5': 5, '10': 'size'},
    {'1': 'attachmentId', '3': 4, '4': 1, '5': 9, '10': 'attachmentId'},
  ],
};

/// Descriptor for `SyncOutlookEmailAttachment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncOutlookEmailAttachmentDescriptor = $convert.base64Decode(
    'ChpTeW5jT3V0bG9va0VtYWlsQXR0YWNobWVudBIaCghmaWxlbmFtZRgBIAEoCVIIZmlsZW5hbW'
    'USGgoIbWltZVR5cGUYAiABKAlSCG1pbWVUeXBlEhIKBHNpemUYAyABKAVSBHNpemUSIgoMYXR0'
    'YWNobWVudElkGAQgASgJUgxhdHRhY2htZW50SWQ=');

