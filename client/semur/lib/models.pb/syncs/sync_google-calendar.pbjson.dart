//
//  Generated code. Do not modify.
//  source: syncs/sync_google-calendar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncGoogleCalendarEventDescriptor instead')
const SyncGoogleCalendarEvent$json = {
  '1': 'SyncGoogleCalendarEvent',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'kind', '3': 2, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'etag', '3': 3, '4': 1, '5': 9, '10': 'etag'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'htmlLink', '3': 5, '4': 1, '5': 9, '10': 'htmlLink'},
    {'1': 'created', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    {'1': 'updated', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updated'},
    {'1': 'summary', '3': 8, '4': 1, '5': 9, '10': 'summary'},
    {'1': 'description', '3': 9, '4': 1, '5': 9, '10': 'description'},
    {'1': 'fullContent', '3': 10, '4': 1, '5': 9, '10': 'fullContent'},
    {'1': 'location', '3': 11, '4': 1, '5': 9, '9': 0, '10': 'location', '17': true},
    {'1': 'creator', '3': 12, '4': 1, '5': 11, '6': '.syncs.SyncGoogleCalendarEventCreator', '9': 1, '10': 'creator', '17': true},
    {'1': 'organizer', '3': 13, '4': 1, '5': 11, '6': '.syncs.SyncGoogleCalendarEventOrganizer', '9': 2, '10': 'organizer', '17': true},
    {'1': 'start', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'start'},
    {'1': 'end', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'end'},
    {'1': 'endTimeUnspecified', '3': 16, '4': 1, '5': 8, '9': 3, '10': 'endTimeUnspecified', '17': true},
    {'1': 'recurrence', '3': 17, '4': 3, '5': 9, '10': 'recurrence'},
    {'1': 'recurringEventId', '3': 18, '4': 1, '5': 9, '9': 4, '10': 'recurringEventId', '17': true},
    {'1': 'attendees', '3': 19, '4': 3, '5': 11, '6': '.syncs.SyncGoogleCalendarEventAttendee', '10': 'attendees'},
    {'1': 'attendeesOmitted', '3': 20, '4': 1, '5': 8, '9': 5, '10': 'attendeesOmitted', '17': true},
    {'1': 'hangoutLink', '3': 21, '4': 1, '5': 9, '9': 6, '10': 'hangoutLink', '17': true},
    {'1': 'nango_metadata', '3': 22, '4': 1, '5': 11, '6': '.syncs.SyncNangoMetadata', '10': 'nangoMetadata'},
  ],
  '8': [
    {'1': '_location'},
    {'1': '_creator'},
    {'1': '_organizer'},
    {'1': '_endTimeUnspecified'},
    {'1': '_recurringEventId'},
    {'1': '_attendeesOmitted'},
    {'1': '_hangoutLink'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventDescriptor = $convert.base64Decode(
    'ChdTeW5jR29vZ2xlQ2FsZW5kYXJFdmVudBIOCgJpZBgBIAEoCVICaWQSEgoEa2luZBgCIAEoCV'
    'IEa2luZBISCgRldGFnGAMgASgJUgRldGFnEhYKBnN0YXR1cxgEIAEoCVIGc3RhdHVzEhoKCGh0'
    'bWxMaW5rGAUgASgJUghodG1sTGluaxI0CgdjcmVhdGVkGAYgASgLMhouZ29vZ2xlLnByb3RvYn'
    'VmLlRpbWVzdGFtcFIHY3JlYXRlZBI0Cgd1cGRhdGVkGAcgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIHdXBkYXRlZBIYCgdzdW1tYXJ5GAggASgJUgdzdW1tYXJ5EiAKC2Rlc2NyaX'
    'B0aW9uGAkgASgJUgtkZXNjcmlwdGlvbhIgCgtmdWxsQ29udGVudBgKIAEoCVILZnVsbENvbnRl'
    'bnQSHwoIbG9jYXRpb24YCyABKAlIAFIIbG9jYXRpb26IAQESRAoHY3JlYXRvchgMIAEoCzIlLn'
    'N5bmNzLlN5bmNHb29nbGVDYWxlbmRhckV2ZW50Q3JlYXRvckgBUgdjcmVhdG9yiAEBEkoKCW9y'
    'Z2FuaXplchgNIAEoCzInLnN5bmNzLlN5bmNHb29nbGVDYWxlbmRhckV2ZW50T3JnYW5pemVySA'
    'JSCW9yZ2FuaXplcogBARIwCgVzdGFydBgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3Rh'
    'bXBSBXN0YXJ0EiwKA2VuZBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSA2VuZB'
    'IzChJlbmRUaW1lVW5zcGVjaWZpZWQYECABKAhIA1ISZW5kVGltZVVuc3BlY2lmaWVkiAEBEh4K'
    'CnJlY3VycmVuY2UYESADKAlSCnJlY3VycmVuY2USLwoQcmVjdXJyaW5nRXZlbnRJZBgSIAEoCU'
    'gEUhByZWN1cnJpbmdFdmVudElkiAEBEkQKCWF0dGVuZGVlcxgTIAMoCzImLnN5bmNzLlN5bmNH'
    'b29nbGVDYWxlbmRhckV2ZW50QXR0ZW5kZWVSCWF0dGVuZGVlcxIvChBhdHRlbmRlZXNPbWl0dG'
    'VkGBQgASgISAVSEGF0dGVuZGVlc09taXR0ZWSIAQESJQoLaGFuZ291dExpbmsYFSABKAlIBlIL'
    'aGFuZ291dExpbmuIAQESPwoObmFuZ29fbWV0YWRhdGEYFiABKAsyGC5zeW5jcy5TeW5jTmFuZ2'
    '9NZXRhZGF0YVINbmFuZ29NZXRhZGF0YUILCglfbG9jYXRpb25CCgoIX2NyZWF0b3JCDAoKX29y'
    'Z2FuaXplckIVChNfZW5kVGltZVVuc3BlY2lmaWVkQhMKEV9yZWN1cnJpbmdFdmVudElkQhMKEV'
    '9hdHRlbmRlZXNPbWl0dGVkQg4KDF9oYW5nb3V0TGluaw==');

@$core.Deprecated('Use syncGoogleCalendarEventCreatorDescriptor instead')
const SyncGoogleCalendarEventCreator$json = {
  '1': 'SyncGoogleCalendarEventCreator',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'email', '17': true},
    {'1': 'displayName', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'displayName', '17': true},
    {'1': 'self', '3': 4, '4': 1, '5': 8, '9': 3, '10': 'self', '17': true},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_email'},
    {'1': '_displayName'},
    {'1': '_self'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEventCreator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventCreatorDescriptor = $convert.base64Decode(
    'Ch5TeW5jR29vZ2xlQ2FsZW5kYXJFdmVudENyZWF0b3ISEwoCaWQYASABKAlIAFICaWSIAQESGQ'
    'oFZW1haWwYAiABKAlIAVIFZW1haWyIAQESJQoLZGlzcGxheU5hbWUYAyABKAlIAlILZGlzcGxh'
    'eU5hbWWIAQESFwoEc2VsZhgEIAEoCEgDUgRzZWxmiAEBQgUKA19pZEIICgZfZW1haWxCDgoMX2'
    'Rpc3BsYXlOYW1lQgcKBV9zZWxm');

@$core.Deprecated('Use syncGoogleCalendarEventOrganizerDescriptor instead')
const SyncGoogleCalendarEventOrganizer$json = {
  '1': 'SyncGoogleCalendarEventOrganizer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'email', '17': true},
    {'1': 'displayName', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'displayName', '17': true},
    {'1': 'self', '3': 4, '4': 1, '5': 8, '9': 3, '10': 'self', '17': true},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_email'},
    {'1': '_displayName'},
    {'1': '_self'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEventOrganizer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventOrganizerDescriptor = $convert.base64Decode(
    'CiBTeW5jR29vZ2xlQ2FsZW5kYXJFdmVudE9yZ2FuaXplchITCgJpZBgBIAEoCUgAUgJpZIgBAR'
    'IZCgVlbWFpbBgCIAEoCUgBUgVlbWFpbIgBARIlCgtkaXNwbGF5TmFtZRgDIAEoCUgCUgtkaXNw'
    'bGF5TmFtZYgBARIXCgRzZWxmGAQgASgISANSBHNlbGaIAQFCBQoDX2lkQggKBl9lbWFpbEIOCg'
    'xfZGlzcGxheU5hbWVCBwoFX3NlbGY=');

@$core.Deprecated('Use syncGoogleCalendarEventAttendeeDescriptor instead')
const SyncGoogleCalendarEventAttendee$json = {
  '1': 'SyncGoogleCalendarEventAttendee',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'email', '17': true},
    {'1': 'displayName', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'displayName', '17': true},
    {'1': 'organizer', '3': 4, '4': 1, '5': 8, '9': 3, '10': 'organizer', '17': true},
    {'1': 'self', '3': 5, '4': 1, '5': 8, '9': 4, '10': 'self', '17': true},
    {'1': 'resource', '3': 6, '4': 1, '5': 8, '9': 5, '10': 'resource', '17': true},
    {'1': 'optional', '3': 7, '4': 1, '5': 8, '9': 6, '10': 'optional', '17': true},
    {'1': 'responseStatus', '3': 8, '4': 1, '5': 9, '9': 7, '10': 'responseStatus', '17': true},
    {'1': 'comment', '3': 9, '4': 1, '5': 9, '9': 8, '10': 'comment', '17': true},
    {'1': 'additionalGuests', '3': 10, '4': 1, '5': 5, '9': 9, '10': 'additionalGuests', '17': true},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_email'},
    {'1': '_displayName'},
    {'1': '_organizer'},
    {'1': '_self'},
    {'1': '_resource'},
    {'1': '_optional'},
    {'1': '_responseStatus'},
    {'1': '_comment'},
    {'1': '_additionalGuests'},
  ],
};

/// Descriptor for `SyncGoogleCalendarEventAttendee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncGoogleCalendarEventAttendeeDescriptor = $convert.base64Decode(
    'Ch9TeW5jR29vZ2xlQ2FsZW5kYXJFdmVudEF0dGVuZGVlEhMKAmlkGAEgASgJSABSAmlkiAEBEh'
    'kKBWVtYWlsGAIgASgJSAFSBWVtYWlsiAEBEiUKC2Rpc3BsYXlOYW1lGAMgASgJSAJSC2Rpc3Bs'
    'YXlOYW1liAEBEiEKCW9yZ2FuaXplchgEIAEoCEgDUglvcmdhbml6ZXKIAQESFwoEc2VsZhgFIA'
    'EoCEgEUgRzZWxmiAEBEh8KCHJlc291cmNlGAYgASgISAVSCHJlc291cmNliAEBEh8KCG9wdGlv'
    'bmFsGAcgASgISAZSCG9wdGlvbmFsiAEBEisKDnJlc3BvbnNlU3RhdHVzGAggASgJSAdSDnJlc3'
    'BvbnNlU3RhdHVziAEBEh0KB2NvbW1lbnQYCSABKAlICFIHY29tbWVudIgBARIvChBhZGRpdGlv'
    'bmFsR3Vlc3RzGAogASgFSAlSEGFkZGl0aW9uYWxHdWVzdHOIAQFCBQoDX2lkQggKBl9lbWFpbE'
    'IOCgxfZGlzcGxheU5hbWVCDAoKX29yZ2FuaXplckIHCgVfc2VsZkILCglfcmVzb3VyY2VCCwoJ'
    'X29wdGlvbmFsQhEKD19yZXNwb25zZVN0YXR1c0IKCghfY29tbWVudEITChFfYWRkaXRpb25hbE'
    'd1ZXN0cw==');

