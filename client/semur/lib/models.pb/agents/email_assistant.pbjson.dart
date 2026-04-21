//
//  Generated code. Do not modify.
//  source: agents/email_assistant.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emailAssistantMentionedEmailDescriptor instead')
const EmailAssistantMentionedEmail$json = {
  '1': 'EmailAssistantMentionedEmail',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'nangoIntegrationId', '3': 2, '4': 1, '5': 9, '10': 'nangoIntegrationId'},
    {'1': 'provider', '3': 3, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'senderName', '3': 5, '4': 1, '5': 9, '10': 'senderName'},
    {'1': 'senderEmail', '3': 6, '4': 1, '5': 9, '10': 'senderEmail'},
    {'1': 'snippet', '3': 7, '4': 1, '5': 9, '10': 'snippet'},
    {'1': 'date', '3': 8, '4': 1, '5': 9, '10': 'date'},
    {'1': 'importanceScore', '3': 9, '4': 1, '5': 2, '10': 'importanceScore'},
  ],
};

/// Descriptor for `EmailAssistantMentionedEmail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantMentionedEmailDescriptor = $convert.base64Decode(
    'ChxFbWFpbEFzc2lzdGFudE1lbnRpb25lZEVtYWlsEg4KAmlkGAEgASgJUgJpZBIuChJuYW5nb0'
    'ludGVncmF0aW9uSWQYAiABKAlSEm5hbmdvSW50ZWdyYXRpb25JZBIaCghwcm92aWRlchgDIAEo'
    'CVIIcHJvdmlkZXISGAoHc3ViamVjdBgEIAEoCVIHc3ViamVjdBIeCgpzZW5kZXJOYW1lGAUgAS'
    'gJUgpzZW5kZXJOYW1lEiAKC3NlbmRlckVtYWlsGAYgASgJUgtzZW5kZXJFbWFpbBIYCgdzbmlw'
    'cGV0GAcgASgJUgdzbmlwcGV0EhIKBGRhdGUYCCABKAlSBGRhdGUSKAoPaW1wb3J0YW5jZVNjb3'
    'JlGAkgASgCUg9pbXBvcnRhbmNlU2NvcmU=');

@$core.Deprecated('Use emailAssistantSuggestedReplyDescriptor instead')
const EmailAssistantSuggestedReply$json = {
  '1': 'EmailAssistantSuggestedReply',
  '2': [
    {'1': 'replyText', '3': 1, '4': 1, '5': 9, '10': 'replyText'},
    {'1': 'replySubject', '3': 2, '4': 1, '5': 9, '10': 'replySubject'},
  ],
};

/// Descriptor for `EmailAssistantSuggestedReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantSuggestedReplyDescriptor = $convert.base64Decode(
    'ChxFbWFpbEFzc2lzdGFudFN1Z2dlc3RlZFJlcGx5EhwKCXJlcGx5VGV4dBgBIAEoCVIJcmVwbH'
    'lUZXh0EiIKDHJlcGx5U3ViamVjdBgCIAEoCVIMcmVwbHlTdWJqZWN0');

@$core.Deprecated('Use emailAssistantChatOutputDescriptor instead')
const EmailAssistantChatOutput$json = {
  '1': 'EmailAssistantChatOutput',
  '2': [
    {'1': 'replyText', '3': 1, '4': 1, '5': 9, '10': 'replyText'},
    {'1': 'artifacts', '3': 2, '4': 1, '5': 11, '6': '.agents.EmailAssistantChatArtifacts', '10': 'artifacts'},
    {'1': 'metadata', '3': 3, '4': 1, '5': 11, '6': '.agents.EmailAssistantChatMetadata', '10': 'metadata'},
  ],
};

/// Descriptor for `EmailAssistantChatOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantChatOutputDescriptor = $convert.base64Decode(
    'ChhFbWFpbEFzc2lzdGFudENoYXRPdXRwdXQSHAoJcmVwbHlUZXh0GAEgASgJUglyZXBseVRleH'
    'QSQQoJYXJ0aWZhY3RzGAIgASgLMiMuYWdlbnRzLkVtYWlsQXNzaXN0YW50Q2hhdEFydGlmYWN0'
    'c1IJYXJ0aWZhY3RzEj4KCG1ldGFkYXRhGAMgASgLMiIuYWdlbnRzLkVtYWlsQXNzaXN0YW50Q2'
    'hhdE1ldGFkYXRhUghtZXRhZGF0YQ==');

@$core.Deprecated('Use emailAssistantChatArtifactsDescriptor instead')
const EmailAssistantChatArtifacts$json = {
  '1': 'EmailAssistantChatArtifacts',
  '2': [
    {'1': 'mentionedEmails', '3': 1, '4': 3, '5': 11, '6': '.agents.EmailAssistantMentionedEmail', '10': 'mentionedEmails'},
  ],
};

/// Descriptor for `EmailAssistantChatArtifacts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantChatArtifactsDescriptor = $convert.base64Decode(
    'ChtFbWFpbEFzc2lzdGFudENoYXRBcnRpZmFjdHMSTgoPbWVudGlvbmVkRW1haWxzGAEgAygLMi'
    'QuYWdlbnRzLkVtYWlsQXNzaXN0YW50TWVudGlvbmVkRW1haWxSD21lbnRpb25lZEVtYWlscw==');

@$core.Deprecated('Use emailAssistantChatMetadataDescriptor instead')
const EmailAssistantChatMetadata$json = {
  '1': 'EmailAssistantChatMetadata',
  '2': [
    {'1': 'totalEmailsAnalyzed', '3': 1, '4': 1, '5': 5, '10': 'totalEmailsAnalyzed'},
    {'1': 'timeRange', '3': 2, '4': 1, '5': 9, '10': 'timeRange'},
  ],
};

/// Descriptor for `EmailAssistantChatMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantChatMetadataDescriptor = $convert.base64Decode(
    'ChpFbWFpbEFzc2lzdGFudENoYXRNZXRhZGF0YRIwChN0b3RhbEVtYWlsc0FuYWx5emVkGAEgAS'
    'gFUhN0b3RhbEVtYWlsc0FuYWx5emVkEhwKCXRpbWVSYW5nZRgCIAEoCVIJdGltZVJhbmdl');

@$core.Deprecated('Use emailAssistantGenerateResponseEmailInputDescriptor instead')
const EmailAssistantGenerateResponseEmailInput$json = {
  '1': 'EmailAssistantGenerateResponseEmailInput',
  '2': [
    {'1': 'from', '3': 1, '4': 1, '5': 9, '10': 'from'},
    {'1': 'to', '3': 2, '4': 1, '5': 9, '10': 'to'},
    {'1': 'date', '3': 3, '4': 1, '5': 9, '10': 'date'},
    {'1': 'subject', '3': 4, '4': 1, '5': 9, '10': 'subject'},
    {'1': 'body', '3': 5, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `EmailAssistantGenerateResponseEmailInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantGenerateResponseEmailInputDescriptor = $convert.base64Decode(
    'CihFbWFpbEFzc2lzdGFudEdlbmVyYXRlUmVzcG9uc2VFbWFpbElucHV0EhIKBGZyb20YASABKA'
    'lSBGZyb20SDgoCdG8YAiABKAlSAnRvEhIKBGRhdGUYAyABKAlSBGRhdGUSGAoHc3ViamVjdBgE'
    'IAEoCVIHc3ViamVjdBISCgRib2R5GAUgASgJUgRib2R5');

@$core.Deprecated('Use emailAssistantGenerateResponseEmailOutputDescriptor instead')
const EmailAssistantGenerateResponseEmailOutput$json = {
  '1': 'EmailAssistantGenerateResponseEmailOutput',
  '2': [
    {'1': 'responseEmailSubject', '3': 1, '4': 1, '5': 9, '10': 'responseEmailSubject'},
    {'1': 'responseEmailBody', '3': 2, '4': 1, '5': 9, '10': 'responseEmailBody'},
  ],
};

/// Descriptor for `EmailAssistantGenerateResponseEmailOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emailAssistantGenerateResponseEmailOutputDescriptor = $convert.base64Decode(
    'CilFbWFpbEFzc2lzdGFudEdlbmVyYXRlUmVzcG9uc2VFbWFpbE91dHB1dBIyChRyZXNwb25zZU'
    'VtYWlsU3ViamVjdBgBIAEoCVIUcmVzcG9uc2VFbWFpbFN1YmplY3QSLAoRcmVzcG9uc2VFbWFp'
    'bEJvZHkYAiABKAlSEXJlc3BvbnNlRW1haWxCb2R5');

