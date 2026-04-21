//
//  Generated code. Do not modify.
//  source: chats/chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use chatRoleDescriptor instead')
const ChatRole$json = {
  '1': 'ChatRole',
  '2': [
    {'1': 'USER', '2': 0},
    {'1': 'MODEL', '2': 1},
    {'1': 'SYSTEM', '2': 2},
    {'1': 'TOOL', '2': 3},
  ],
};

/// Descriptor for `ChatRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List chatRoleDescriptor = $convert.base64Decode(
    'CghDaGF0Um9sZRIICgRVU0VSEAASCQoFTU9ERUwQARIKCgZTWVNURU0QAhIICgRUT09MEAM=');

@$core.Deprecated('Use chatMessageDescriptor instead')
const ChatMessage$json = {
  '1': 'ChatMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'role', '3': 2, '4': 1, '5': 14, '6': '.chats.ChatRole', '10': 'role'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    {'1': 'follow_up_questions', '3': 5, '4': 3, '5': 9, '10': 'followUpQuestions'},
    {'1': 'metadata', '3': 6, '4': 1, '5': 11, '6': '.chats.ChatMetadata', '9': 0, '10': 'metadata', '17': true},
    {'1': 'artifacts', '3': 7, '4': 1, '5': 11, '6': '.chats.ChatArtifacts', '9': 1, '10': 'artifacts', '17': true},
    {'1': 'output', '3': 8, '4': 1, '5': 9, '9': 2, '10': 'output', '17': true},
    {'1': 'toolName', '3': 9, '4': 1, '5': 9, '9': 3, '10': 'toolName', '17': true},
    {'1': 'toolRequestJson', '3': 10, '4': 1, '5': 9, '9': 4, '10': 'toolRequestJson', '17': true},
    {'1': 'toolResponseJson', '3': 11, '4': 1, '5': 9, '9': 5, '10': 'toolResponseJson', '17': true},
    {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
  '8': [
    {'1': '_metadata'},
    {'1': '_artifacts'},
    {'1': '_output'},
    {'1': '_toolName'},
    {'1': '_toolRequestJson'},
    {'1': '_toolResponseJson'},
  ],
};

/// Descriptor for `ChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageDescriptor = $convert.base64Decode(
    'CgtDaGF0TWVzc2FnZRIOCgJpZBgBIAEoBVICaWQSIwoEcm9sZRgCIAEoDjIPLmNoYXRzLkNoYX'
    'RSb2xlUgRyb2xlEhYKBmF1dGhvchgDIAEoCVIGYXV0aG9yEhgKB2NvbnRlbnQYBCABKAlSB2Nv'
    'bnRlbnQSLgoTZm9sbG93X3VwX3F1ZXN0aW9ucxgFIAMoCVIRZm9sbG93VXBRdWVzdGlvbnMSNA'
    'oIbWV0YWRhdGEYBiABKAsyEy5jaGF0cy5DaGF0TWV0YWRhdGFIAFIIbWV0YWRhdGGIAQESNwoJ'
    'YXJ0aWZhY3RzGAcgASgLMhQuY2hhdHMuQ2hhdEFydGlmYWN0c0gBUglhcnRpZmFjdHOIAQESGw'
    'oGb3V0cHV0GAggASgJSAJSBm91dHB1dIgBARIfCgh0b29sTmFtZRgJIAEoCUgDUgh0b29sTmFt'
    'ZYgBARItCg90b29sUmVxdWVzdEpzb24YCiABKAlIBFIPdG9vbFJlcXVlc3RKc29uiAEBEi8KEH'
    'Rvb2xSZXNwb25zZUpzb24YCyABKAlIBVIQdG9vbFJlc3BvbnNlSnNvbogBARI5CgpjcmVhdGVk'
    'X2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0QgsKCV9tZX'
    'RhZGF0YUIMCgpfYXJ0aWZhY3RzQgkKB19vdXRwdXRCCwoJX3Rvb2xOYW1lQhIKEF90b29sUmVx'
    'dWVzdEpzb25CEwoRX3Rvb2xSZXNwb25zZUpzb24=');

@$core.Deprecated('Use chatMetadataDescriptor instead')
const ChatMetadata$json = {
  '1': 'ChatMetadata',
  '2': [
    {'1': 'email_assistant', '3': 1, '4': 1, '5': 11, '6': '.agents.EmailAssistantChatMetadata', '10': 'emailAssistant'},
  ],
};

/// Descriptor for `ChatMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMetadataDescriptor = $convert.base64Decode(
    'CgxDaGF0TWV0YWRhdGESSwoPZW1haWxfYXNzaXN0YW50GAEgASgLMiIuYWdlbnRzLkVtYWlsQX'
    'NzaXN0YW50Q2hhdE1ldGFkYXRhUg5lbWFpbEFzc2lzdGFudA==');

@$core.Deprecated('Use chatArtifactsDescriptor instead')
const ChatArtifacts$json = {
  '1': 'ChatArtifacts',
  '2': [
    {'1': 'email_assistant', '3': 1, '4': 1, '5': 11, '6': '.agents.EmailAssistantChatArtifacts', '10': 'emailAssistant'},
  ],
};

/// Descriptor for `ChatArtifacts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatArtifactsDescriptor = $convert.base64Decode(
    'Cg1DaGF0QXJ0aWZhY3RzEkwKD2VtYWlsX2Fzc2lzdGFudBgBIAEoCzIjLmFnZW50cy5FbWFpbE'
    'Fzc2lzdGFudENoYXRBcnRpZmFjdHNSDmVtYWlsQXNzaXN0YW50');

@$core.Deprecated('Use chatSessionDescriptor instead')
const ChatSession$json = {
  '1': 'ChatSession',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'agent_category', '3': 3, '4': 1, '5': 14, '6': '.agents.AgentCategory', '10': 'agentCategory'},
    {'1': 'current_message_index', '3': 4, '4': 1, '5': 5, '10': 'currentMessageIndex'},
    {'1': 'created_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'title', '3': 6, '4': 1, '5': 9, '10': 'title'},
  ],
};

/// Descriptor for `ChatSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatSessionDescriptor = $convert.base64Decode(
    'CgtDaGF0U2Vzc2lvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEj'
    'wKDmFnZW50X2NhdGVnb3J5GAMgASgOMhUuYWdlbnRzLkFnZW50Q2F0ZWdvcnlSDWFnZW50Q2F0'
    'ZWdvcnkSMgoVY3VycmVudF9tZXNzYWdlX2luZGV4GAQgASgFUhNjdXJyZW50TWVzc2FnZUluZG'
    'V4EjkKCmNyZWF0ZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVh'
    'dGVkQXQSFAoFdGl0bGUYBiABKAlSBXRpdGxl');

