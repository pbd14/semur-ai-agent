//
//  Generated code. Do not modify.
//  source: nango/nango.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use nangoIntegrationStatusDescriptor instead')
const NangoIntegrationStatus$json = {
  '1': 'NangoIntegrationStatus',
  '2': [
    {'1': 'INACTIVE', '2': 0},
    {'1': 'ACTIVE', '2': 1},
  ],
};

/// Descriptor for `NangoIntegrationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nangoIntegrationStatusDescriptor = $convert.base64Decode(
    'ChZOYW5nb0ludGVncmF0aW9uU3RhdHVzEgwKCElOQUNUSVZFEAASCgoGQUNUSVZFEAE=');

@$core.Deprecated('Use nangoConnectionStatusDescriptor instead')
const NangoConnectionStatus$json = {
  '1': 'NangoConnectionStatus',
  '2': [
    {'1': 'NANGO_CONNECTION_INACTIVE', '2': 0},
    {'1': 'NANGO_CONNECTION_ACTIVE', '2': 1},
    {'1': 'NANGO_CONNECTION_CONNECTING', '2': 2},
  ],
};

/// Descriptor for `NangoConnectionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nangoConnectionStatusDescriptor = $convert.base64Decode(
    'ChVOYW5nb0Nvbm5lY3Rpb25TdGF0dXMSHQoZTkFOR09fQ09OTkVDVElPTl9JTkFDVElWRRAAEh'
    'sKF05BTkdPX0NPTk5FQ1RJT05fQUNUSVZFEAESHwobTkFOR09fQ09OTkVDVElPTl9DT05ORUNU'
    'SU5HEAI=');

@$core.Deprecated('Use nangoIntegrationDescriptor instead')
const NangoIntegration$json = {
  '1': 'NangoIntegration',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.nango.NangoIntegrationStatus', '10': 'status'},
    {'1': 'categories', '3': 4, '4': 3, '5': 14, '6': '.agents.AgentCategory', '10': 'categories'},
  ],
};

/// Descriptor for `NangoIntegration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoIntegrationDescriptor = $convert.base64Decode(
    'ChBOYW5nb0ludGVncmF0aW9uEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEj'
    'UKBnN0YXR1cxgDIAEoDjIdLm5hbmdvLk5hbmdvSW50ZWdyYXRpb25TdGF0dXNSBnN0YXR1cxI1'
    'CgpjYXRlZ29yaWVzGAQgAygOMhUuYWdlbnRzLkFnZW50Q2F0ZWdvcnlSCmNhdGVnb3JpZXM=');

@$core.Deprecated('Use nangoConnectionErrorDescriptor instead')
const NangoConnectionError$json = {
  '1': 'NangoConnectionError',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `NangoConnectionError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionErrorDescriptor = $convert.base64Decode(
    'ChROYW5nb0Nvbm5lY3Rpb25FcnJvchISCgR0eXBlGAEgASgJUgR0eXBlEhgKB21lc3NhZ2UYAi'
    'ABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use nangoConnectionDescriptor instead')
const NangoConnection$json = {
  '1': 'NangoConnection',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'connection_id', '3': 3, '4': 1, '5': 9, '10': 'connectionId'},
    {'1': 'organization_id', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'organizationId', '17': true},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.nango.NangoConnectionStatus', '10': 'status'},
    {'1': 'provider', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'provider', '17': true},
    {'1': 'auth_mode', '3': 7, '4': 1, '5': 9, '9': 2, '10': 'authMode', '17': true},
    {'1': 'nango_error', '3': 8, '4': 1, '5': 11, '6': '.nango.NangoConnectionError', '9': 3, '10': 'nangoError', '17': true},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '8': [
    {'1': '_organization_id'},
    {'1': '_provider'},
    {'1': '_auth_mode'},
    {'1': '_nango_error'},
  ],
};

/// Descriptor for `NangoConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionDescriptor = $convert.base64Decode(
    'Cg9OYW5nb0Nvbm5lY3Rpb24SDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIjCg1jb25uZWN0aW9uX2lkGAMgASgJUgxjb25uZWN0aW9uSWQSLAoPb3JnYW5pemF0aW9u'
    'X2lkGAQgASgJSABSDm9yZ2FuaXphdGlvbklkiAEBEjQKBnN0YXR1cxgFIAEoDjIcLm5hbmdvLk'
    '5hbmdvQ29ubmVjdGlvblN0YXR1c1IGc3RhdHVzEh8KCHByb3ZpZGVyGAYgASgJSAFSCHByb3Zp'
    'ZGVyiAEBEiAKCWF1dGhfbW9kZRgHIAEoCUgCUghhdXRoTW9kZYgBARJBCgtuYW5nb19lcnJvch'
    'gIIAEoCzIbLm5hbmdvLk5hbmdvQ29ubmVjdGlvbkVycm9ySANSCm5hbmdvRXJyb3KIAQESOQoK'
    'dXBkYXRlZF9hdBgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdE'
    'ISChBfb3JnYW5pemF0aW9uX2lkQgsKCV9wcm92aWRlckIMCgpfYXV0aF9tb2RlQg4KDF9uYW5n'
    'b19lcnJvcg==');

@$core.Deprecated('Use nangoConnectionPublicDescriptor instead')
const NangoConnectionPublic$json = {
  '1': 'NangoConnectionPublic',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'organization_id', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'organizationId', '17': true},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.nango.NangoConnectionStatus', '10': 'status'},
    {'1': 'provider', '3': 5, '4': 1, '5': 9, '9': 1, '10': 'provider', '17': true},
    {'1': 'updated_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
  '8': [
    {'1': '_organization_id'},
    {'1': '_provider'},
  ],
};

/// Descriptor for `NangoConnectionPublic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nangoConnectionPublicDescriptor = $convert.base64Decode(
    'ChVOYW5nb0Nvbm5lY3Rpb25QdWJsaWMSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKA'
    'lSBnVzZXJJZBIsCg9vcmdhbml6YXRpb25faWQYAyABKAlIAFIOb3JnYW5pemF0aW9uSWSIAQES'
    'NAoGc3RhdHVzGAQgASgOMhwubmFuZ28uTmFuZ29Db25uZWN0aW9uU3RhdHVzUgZzdGF0dXMSHw'
    'oIcHJvdmlkZXIYBSABKAlIAVIIcHJvdmlkZXKIAQESOQoKdXBkYXRlZF9hdBgGIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdEISChBfb3JnYW5pemF0aW9uX2lkQg'
    'sKCV9wcm92aWRlcg==');

