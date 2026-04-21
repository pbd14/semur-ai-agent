//
//  Generated code. Do not modify.
//  source: agents/agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use agentCategoryDescriptor instead')
const AgentCategory$json = {
  '1': 'AgentCategory',
  '2': [
    {'1': 'GENERAL', '2': 0},
    {'1': 'EMAIL', '2': 1},
    {'1': 'CALENDAR', '2': 2},
  ],
};

/// Descriptor for `AgentCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List agentCategoryDescriptor = $convert.base64Decode(
    'Cg1BZ2VudENhdGVnb3J5EgsKB0dFTkVSQUwQABIJCgVFTUFJTBABEgwKCENBTEVOREFSEAI=');

@$core.Deprecated('Use agentToolDescriptor instead')
const AgentTool$json = {
  '1': 'AgentTool',
  '2': [
    {'1': 'SEMUR_CHAT_MENTION_EMAIL', '2': 0},
    {'1': 'GOOGLE_MAIL_GET_EMAILS', '2': 10},
    {'1': 'GOOGLE_MAIL_GET_EMAIL_BY_ID', '2': 11},
    {'1': 'GOOGLE_MAIL_SEARCH_COMMON_FILTERS', '2': 12},
    {'1': 'GOOGLE_MAIL_VECTOR_SEARCH', '2': 13},
    {'1': 'GOOGLE_MAIL_GET_SYNC_INFORMATION', '2': 14},
    {'1': 'GOOGLE_MAIL_SYNC', '2': 15},
    {'1': 'GOOGLE_MAIL_SEND_EMAIL', '2': 16},
    {'1': 'GOOGLE_CALENDAR_GET_EVENTS', '2': 20},
    {'1': 'GOOGLE_CALENDAR_SEARCH_COMMON_FILTERS', '2': 21},
    {'1': 'GOOGLE_CALENDAR_VECTOR_SEARCH', '2': 22},
    {'1': 'GOOGLE_CALENDAR_GET_SYNC_INFORMATION', '2': 23},
    {'1': 'GOOGLE_CALENDAR_SYNC', '2': 24},
    {'1': 'OUTLOOK_MAIL_GET_EMAILS', '2': 30},
    {'1': 'OUTLOOK_MAIL_GET_EMAIL_BY_ID', '2': 31},
    {'1': 'OUTLOOK_MAIL_SEARCH_COMMON_FILTERS', '2': 32},
    {'1': 'OUTLOOK_MAIL_VECTOR_SEARCH', '2': 33},
    {'1': 'OUTLOOK_MAIL_GET_SYNC_INFORMATION', '2': 34},
    {'1': 'OUTLOOK_MAIL_SYNC', '2': 35},
    {'1': 'OUTLOOK_MAIL_SEND_EMAIL', '2': 36},
  ],
};

/// Descriptor for `AgentTool`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List agentToolDescriptor = $convert.base64Decode(
    'CglBZ2VudFRvb2wSHAoYU0VNVVJfQ0hBVF9NRU5USU9OX0VNQUlMEAASGgoWR09PR0xFX01BSU'
    'xfR0VUX0VNQUlMUxAKEh8KG0dPT0dMRV9NQUlMX0dFVF9FTUFJTF9CWV9JRBALEiUKIUdPT0dM'
    'RV9NQUlMX1NFQVJDSF9DT01NT05fRklMVEVSUxAMEh0KGUdPT0dMRV9NQUlMX1ZFQ1RPUl9TRU'
    'FSQ0gQDRIkCiBHT09HTEVfTUFJTF9HRVRfU1lOQ19JTkZPUk1BVElPThAOEhQKEEdPT0dMRV9N'
    'QUlMX1NZTkMQDxIaChZHT09HTEVfTUFJTF9TRU5EX0VNQUlMEBASHgoaR09PR0xFX0NBTEVORE'
    'FSX0dFVF9FVkVOVFMQFBIpCiVHT09HTEVfQ0FMRU5EQVJfU0VBUkNIX0NPTU1PTl9GSUxURVJT'
    'EBUSIQodR09PR0xFX0NBTEVOREFSX1ZFQ1RPUl9TRUFSQ0gQFhIoCiRHT09HTEVfQ0FMRU5EQV'
    'JfR0VUX1NZTkNfSU5GT1JNQVRJT04QFxIYChRHT09HTEVfQ0FMRU5EQVJfU1lOQxAYEhsKF09V'
    'VExPT0tfTUFJTF9HRVRfRU1BSUxTEB4SIAocT1VUTE9PS19NQUlMX0dFVF9FTUFJTF9CWV9JRB'
    'AfEiYKIk9VVExPT0tfTUFJTF9TRUFSQ0hfQ09NTU9OX0ZJTFRFUlMQIBIeChpPVVRMT09LX01B'
    'SUxfVkVDVE9SX1NFQVJDSBAhEiUKIU9VVExPT0tfTUFJTF9HRVRfU1lOQ19JTkZPUk1BVElPTh'
    'AiEhUKEU9VVExPT0tfTUFJTF9TWU5DECMSGwoXT1VUTE9PS19NQUlMX1NFTkRfRU1BSUwQJA==');

@$core.Deprecated('Use agentMoodDescriptor instead')
const AgentMood$json = {
  '1': 'AgentMood',
  '2': [
    {'1': 'NORMAL', '2': 0},
    {'1': 'DETERMINISTIC', '2': 1},
    {'1': 'CAREFUL', '2': 2},
    {'1': 'CREATIVE', '2': 3},
    {'1': 'WILD', '2': 4},
  ],
};

/// Descriptor for `AgentMood`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List agentMoodDescriptor = $convert.base64Decode(
    'CglBZ2VudE1vb2QSCgoGTk9STUFMEAASEQoNREVURVJNSU5JU1RJQxABEgsKB0NBUkVGVUwQAh'
    'IMCghDUkVBVElWRRADEggKBFdJTEQQBA==');

@$core.Deprecated('Use agentChatInputDescriptor instead')
const AgentChatInput$json = {
  '1': 'AgentChatInput',
  '2': [
    {'1': 'userId', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'sessionId', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
    {'1': 'connectionIds', '3': 3, '4': 3, '5': 9, '10': 'connectionIds'},
    {'1': 'userMessage', '3': 4, '4': 1, '5': 9, '10': 'userMessage'},
    {'1': 'fastMode', '3': 5, '4': 1, '5': 8, '10': 'fastMode'},
    {'1': 'proMode', '3': 6, '4': 1, '5': 8, '10': 'proMode'},
    {'1': 'agentMood', '3': 7, '4': 1, '5': 14, '6': '.agents.AgentMood', '9': 0, '10': 'agentMood', '17': true},
  ],
  '8': [
    {'1': '_agentMood'},
  ],
};

/// Descriptor for `AgentChatInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agentChatInputDescriptor = $convert.base64Decode(
    'Cg5BZ2VudENoYXRJbnB1dBIWCgZ1c2VySWQYASABKAlSBnVzZXJJZBIcCglzZXNzaW9uSWQYAi'
    'ABKAlSCXNlc3Npb25JZBIkCg1jb25uZWN0aW9uSWRzGAMgAygJUg1jb25uZWN0aW9uSWRzEiAK'
    'C3VzZXJNZXNzYWdlGAQgASgJUgt1c2VyTWVzc2FnZRIaCghmYXN0TW9kZRgFIAEoCFIIZmFzdE'
    '1vZGUSGAoHcHJvTW9kZRgGIAEoCFIHcHJvTW9kZRI0CglhZ2VudE1vb2QYByABKA4yES5hZ2Vu'
    'dHMuQWdlbnRNb29kSABSCWFnZW50TW9vZIgBAUIMCgpfYWdlbnRNb29k');

@$core.Deprecated('Use agentChatOutputDescriptor instead')
const AgentChatOutput$json = {
  '1': 'AgentChatOutput',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 14, '6': '.semur_engine.SemurEngineErrorCode', '10': 'error'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'chatOutput', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'chatOutput', '17': true},
  ],
  '8': [
    {'1': '_chatOutput'},
  ],
};

/// Descriptor for `AgentChatOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List agentChatOutputDescriptor = $convert.base64Decode(
    'Cg9BZ2VudENoYXRPdXRwdXQSOAoFZXJyb3IYASABKA4yIi5zZW11cl9lbmdpbmUuU2VtdXJFbm'
    'dpbmVFcnJvckNvZGVSBWVycm9yEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoKY2hhdE91'
    'dHB1dBgDIAEoCUgAUgpjaGF0T3V0cHV0iAEBQg0KC19jaGF0T3V0cHV0');

