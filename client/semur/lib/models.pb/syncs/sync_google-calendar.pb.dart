//
//  Generated code. Do not modify.
//  source: syncs/sync_google-calendar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $0;
import 'sync.pb.dart' as $1;

class SyncGoogleCalendarEvent extends $pb.GeneratedMessage {
  factory SyncGoogleCalendarEvent({
    $core.String? id,
    $core.String? kind,
    $core.String? etag,
    $core.String? status,
    $core.String? htmlLink,
    $0.Timestamp? created,
    $0.Timestamp? updated,
    $core.String? summary,
    $core.String? description,
    $core.String? fullContent,
    $core.String? location,
    SyncGoogleCalendarEventCreator? creator,
    SyncGoogleCalendarEventOrganizer? organizer,
    $0.Timestamp? start,
    $0.Timestamp? end,
    $core.bool? endTimeUnspecified,
    $core.Iterable<$core.String>? recurrence,
    $core.String? recurringEventId,
    $core.Iterable<SyncGoogleCalendarEventAttendee>? attendees,
    $core.bool? attendeesOmitted,
    $core.String? hangoutLink,
    $1.SyncNangoMetadata? nangoMetadata,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (status != null) {
      $result.status = status;
    }
    if (htmlLink != null) {
      $result.htmlLink = htmlLink;
    }
    if (created != null) {
      $result.created = created;
    }
    if (updated != null) {
      $result.updated = updated;
    }
    if (summary != null) {
      $result.summary = summary;
    }
    if (description != null) {
      $result.description = description;
    }
    if (fullContent != null) {
      $result.fullContent = fullContent;
    }
    if (location != null) {
      $result.location = location;
    }
    if (creator != null) {
      $result.creator = creator;
    }
    if (organizer != null) {
      $result.organizer = organizer;
    }
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    if (endTimeUnspecified != null) {
      $result.endTimeUnspecified = endTimeUnspecified;
    }
    if (recurrence != null) {
      $result.recurrence.addAll(recurrence);
    }
    if (recurringEventId != null) {
      $result.recurringEventId = recurringEventId;
    }
    if (attendees != null) {
      $result.attendees.addAll(attendees);
    }
    if (attendeesOmitted != null) {
      $result.attendeesOmitted = attendeesOmitted;
    }
    if (hangoutLink != null) {
      $result.hangoutLink = hangoutLink;
    }
    if (nangoMetadata != null) {
      $result.nangoMetadata = nangoMetadata;
    }
    return $result;
  }
  SyncGoogleCalendarEvent._() : super();
  factory SyncGoogleCalendarEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncGoogleCalendarEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncGoogleCalendarEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'kind')
    ..aOS(3, _omitFieldNames ? '' : 'etag')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'htmlLink', protoName: 'htmlLink')
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'created', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'updated', subBuilder: $0.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'summary')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOS(10, _omitFieldNames ? '' : 'fullContent', protoName: 'fullContent')
    ..aOS(11, _omitFieldNames ? '' : 'location')
    ..aOM<SyncGoogleCalendarEventCreator>(12, _omitFieldNames ? '' : 'creator', subBuilder: SyncGoogleCalendarEventCreator.create)
    ..aOM<SyncGoogleCalendarEventOrganizer>(13, _omitFieldNames ? '' : 'organizer', subBuilder: SyncGoogleCalendarEventOrganizer.create)
    ..aOM<$0.Timestamp>(14, _omitFieldNames ? '' : 'start', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(15, _omitFieldNames ? '' : 'end', subBuilder: $0.Timestamp.create)
    ..aOB(16, _omitFieldNames ? '' : 'endTimeUnspecified', protoName: 'endTimeUnspecified')
    ..pPS(17, _omitFieldNames ? '' : 'recurrence')
    ..aOS(18, _omitFieldNames ? '' : 'recurringEventId', protoName: 'recurringEventId')
    ..pc<SyncGoogleCalendarEventAttendee>(19, _omitFieldNames ? '' : 'attendees', $pb.PbFieldType.PM, subBuilder: SyncGoogleCalendarEventAttendee.create)
    ..aOB(20, _omitFieldNames ? '' : 'attendeesOmitted', protoName: 'attendeesOmitted')
    ..aOS(21, _omitFieldNames ? '' : 'hangoutLink', protoName: 'hangoutLink')
    ..aOM<$1.SyncNangoMetadata>(22, _omitFieldNames ? '' : 'nangoMetadata', subBuilder: $1.SyncNangoMetadata.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEvent clone() => SyncGoogleCalendarEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEvent copyWith(void Function(SyncGoogleCalendarEvent) updates) => super.copyWith((message) => updates(message as SyncGoogleCalendarEvent)) as SyncGoogleCalendarEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEvent create() => SyncGoogleCalendarEvent._();
  SyncGoogleCalendarEvent createEmptyInstance() => create();
  static $pb.PbList<SyncGoogleCalendarEvent> createRepeated() => $pb.PbList<SyncGoogleCalendarEvent>();
  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncGoogleCalendarEvent>(create);
  static SyncGoogleCalendarEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get kind => $_getSZ(1);
  @$pb.TagNumber(2)
  set kind($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get etag => $_getSZ(2);
  @$pb.TagNumber(3)
  set etag($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtag() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get htmlLink => $_getSZ(4);
  @$pb.TagNumber(5)
  set htmlLink($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHtmlLink() => $_has(4);
  @$pb.TagNumber(5)
  void clearHtmlLink() => clearField(5);

  @$pb.TagNumber(6)
  $0.Timestamp get created => $_getN(5);
  @$pb.TagNumber(6)
  set created($0.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreated() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreated() => clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureCreated() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.Timestamp get updated => $_getN(6);
  @$pb.TagNumber(7)
  set updated($0.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdated() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdated() => clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureUpdated() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get summary => $_getSZ(7);
  @$pb.TagNumber(8)
  set summary($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSummary() => $_has(7);
  @$pb.TagNumber(8)
  void clearSummary() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get fullContent => $_getSZ(9);
  @$pb.TagNumber(10)
  set fullContent($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFullContent() => $_has(9);
  @$pb.TagNumber(10)
  void clearFullContent() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get location => $_getSZ(10);
  @$pb.TagNumber(11)
  set location($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLocation() => $_has(10);
  @$pb.TagNumber(11)
  void clearLocation() => clearField(11);

  @$pb.TagNumber(12)
  SyncGoogleCalendarEventCreator get creator => $_getN(11);
  @$pb.TagNumber(12)
  set creator(SyncGoogleCalendarEventCreator v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreator() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreator() => clearField(12);
  @$pb.TagNumber(12)
  SyncGoogleCalendarEventCreator ensureCreator() => $_ensure(11);

  @$pb.TagNumber(13)
  SyncGoogleCalendarEventOrganizer get organizer => $_getN(12);
  @$pb.TagNumber(13)
  set organizer(SyncGoogleCalendarEventOrganizer v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasOrganizer() => $_has(12);
  @$pb.TagNumber(13)
  void clearOrganizer() => clearField(13);
  @$pb.TagNumber(13)
  SyncGoogleCalendarEventOrganizer ensureOrganizer() => $_ensure(12);

  @$pb.TagNumber(14)
  $0.Timestamp get start => $_getN(13);
  @$pb.TagNumber(14)
  set start($0.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasStart() => $_has(13);
  @$pb.TagNumber(14)
  void clearStart() => clearField(14);
  @$pb.TagNumber(14)
  $0.Timestamp ensureStart() => $_ensure(13);

  @$pb.TagNumber(15)
  $0.Timestamp get end => $_getN(14);
  @$pb.TagNumber(15)
  set end($0.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasEnd() => $_has(14);
  @$pb.TagNumber(15)
  void clearEnd() => clearField(15);
  @$pb.TagNumber(15)
  $0.Timestamp ensureEnd() => $_ensure(14);

  @$pb.TagNumber(16)
  $core.bool get endTimeUnspecified => $_getBF(15);
  @$pb.TagNumber(16)
  set endTimeUnspecified($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasEndTimeUnspecified() => $_has(15);
  @$pb.TagNumber(16)
  void clearEndTimeUnspecified() => clearField(16);

  @$pb.TagNumber(17)
  $core.List<$core.String> get recurrence => $_getList(16);

  @$pb.TagNumber(18)
  $core.String get recurringEventId => $_getSZ(17);
  @$pb.TagNumber(18)
  set recurringEventId($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasRecurringEventId() => $_has(17);
  @$pb.TagNumber(18)
  void clearRecurringEventId() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<SyncGoogleCalendarEventAttendee> get attendees => $_getList(18);

  @$pb.TagNumber(20)
  $core.bool get attendeesOmitted => $_getBF(19);
  @$pb.TagNumber(20)
  set attendeesOmitted($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasAttendeesOmitted() => $_has(19);
  @$pb.TagNumber(20)
  void clearAttendeesOmitted() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get hangoutLink => $_getSZ(20);
  @$pb.TagNumber(21)
  set hangoutLink($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasHangoutLink() => $_has(20);
  @$pb.TagNumber(21)
  void clearHangoutLink() => clearField(21);

  @$pb.TagNumber(22)
  $1.SyncNangoMetadata get nangoMetadata => $_getN(21);
  @$pb.TagNumber(22)
  set nangoMetadata($1.SyncNangoMetadata v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasNangoMetadata() => $_has(21);
  @$pb.TagNumber(22)
  void clearNangoMetadata() => clearField(22);
  @$pb.TagNumber(22)
  $1.SyncNangoMetadata ensureNangoMetadata() => $_ensure(21);
}

class SyncGoogleCalendarEventCreator extends $pb.GeneratedMessage {
  factory SyncGoogleCalendarEventCreator({
    $core.String? id,
    $core.String? email,
    $core.String? displayName,
    $core.bool? self,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (email != null) {
      $result.email = email;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (self != null) {
      $result.self = self;
    }
    return $result;
  }
  SyncGoogleCalendarEventCreator._() : super();
  factory SyncGoogleCalendarEventCreator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncGoogleCalendarEventCreator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncGoogleCalendarEventCreator', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName', protoName: 'displayName')
    ..aOB(4, _omitFieldNames ? '' : 'self')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventCreator clone() => SyncGoogleCalendarEventCreator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventCreator copyWith(void Function(SyncGoogleCalendarEventCreator) updates) => super.copyWith((message) => updates(message as SyncGoogleCalendarEventCreator)) as SyncGoogleCalendarEventCreator;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventCreator create() => SyncGoogleCalendarEventCreator._();
  SyncGoogleCalendarEventCreator createEmptyInstance() => create();
  static $pb.PbList<SyncGoogleCalendarEventCreator> createRepeated() => $pb.PbList<SyncGoogleCalendarEventCreator>();
  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventCreator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncGoogleCalendarEventCreator>(create);
  static SyncGoogleCalendarEventCreator? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get self => $_getBF(3);
  @$pb.TagNumber(4)
  set self($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelf() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelf() => clearField(4);
}

class SyncGoogleCalendarEventOrganizer extends $pb.GeneratedMessage {
  factory SyncGoogleCalendarEventOrganizer({
    $core.String? id,
    $core.String? email,
    $core.String? displayName,
    $core.bool? self,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (email != null) {
      $result.email = email;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (self != null) {
      $result.self = self;
    }
    return $result;
  }
  SyncGoogleCalendarEventOrganizer._() : super();
  factory SyncGoogleCalendarEventOrganizer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncGoogleCalendarEventOrganizer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncGoogleCalendarEventOrganizer', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName', protoName: 'displayName')
    ..aOB(4, _omitFieldNames ? '' : 'self')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventOrganizer clone() => SyncGoogleCalendarEventOrganizer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventOrganizer copyWith(void Function(SyncGoogleCalendarEventOrganizer) updates) => super.copyWith((message) => updates(message as SyncGoogleCalendarEventOrganizer)) as SyncGoogleCalendarEventOrganizer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventOrganizer create() => SyncGoogleCalendarEventOrganizer._();
  SyncGoogleCalendarEventOrganizer createEmptyInstance() => create();
  static $pb.PbList<SyncGoogleCalendarEventOrganizer> createRepeated() => $pb.PbList<SyncGoogleCalendarEventOrganizer>();
  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventOrganizer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncGoogleCalendarEventOrganizer>(create);
  static SyncGoogleCalendarEventOrganizer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get self => $_getBF(3);
  @$pb.TagNumber(4)
  set self($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelf() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelf() => clearField(4);
}

class SyncGoogleCalendarEventAttendee extends $pb.GeneratedMessage {
  factory SyncGoogleCalendarEventAttendee({
    $core.String? id,
    $core.String? email,
    $core.String? displayName,
    $core.bool? organizer,
    $core.bool? self,
    $core.bool? resource,
    $core.bool? optional,
    $core.String? responseStatus,
    $core.String? comment,
    $core.int? additionalGuests,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (email != null) {
      $result.email = email;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (organizer != null) {
      $result.organizer = organizer;
    }
    if (self != null) {
      $result.self = self;
    }
    if (resource != null) {
      $result.resource = resource;
    }
    if (optional != null) {
      $result.optional = optional;
    }
    if (responseStatus != null) {
      $result.responseStatus = responseStatus;
    }
    if (comment != null) {
      $result.comment = comment;
    }
    if (additionalGuests != null) {
      $result.additionalGuests = additionalGuests;
    }
    return $result;
  }
  SyncGoogleCalendarEventAttendee._() : super();
  factory SyncGoogleCalendarEventAttendee.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncGoogleCalendarEventAttendee.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncGoogleCalendarEventAttendee', package: const $pb.PackageName(_omitMessageNames ? '' : 'syncs'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName', protoName: 'displayName')
    ..aOB(4, _omitFieldNames ? '' : 'organizer')
    ..aOB(5, _omitFieldNames ? '' : 'self')
    ..aOB(6, _omitFieldNames ? '' : 'resource')
    ..aOB(7, _omitFieldNames ? '' : 'optional')
    ..aOS(8, _omitFieldNames ? '' : 'responseStatus', protoName: 'responseStatus')
    ..aOS(9, _omitFieldNames ? '' : 'comment')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'additionalGuests', $pb.PbFieldType.O3, protoName: 'additionalGuests')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventAttendee clone() => SyncGoogleCalendarEventAttendee()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncGoogleCalendarEventAttendee copyWith(void Function(SyncGoogleCalendarEventAttendee) updates) => super.copyWith((message) => updates(message as SyncGoogleCalendarEventAttendee)) as SyncGoogleCalendarEventAttendee;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventAttendee create() => SyncGoogleCalendarEventAttendee._();
  SyncGoogleCalendarEventAttendee createEmptyInstance() => create();
  static $pb.PbList<SyncGoogleCalendarEventAttendee> createRepeated() => $pb.PbList<SyncGoogleCalendarEventAttendee>();
  @$core.pragma('dart2js:noInline')
  static SyncGoogleCalendarEventAttendee getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncGoogleCalendarEventAttendee>(create);
  static SyncGoogleCalendarEventAttendee? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get organizer => $_getBF(3);
  @$pb.TagNumber(4)
  set organizer($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrganizer() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrganizer() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get self => $_getBF(4);
  @$pb.TagNumber(5)
  set self($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSelf() => $_has(4);
  @$pb.TagNumber(5)
  void clearSelf() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get resource => $_getBF(5);
  @$pb.TagNumber(6)
  set resource($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasResource() => $_has(5);
  @$pb.TagNumber(6)
  void clearResource() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get optional => $_getBF(6);
  @$pb.TagNumber(7)
  set optional($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOptional() => $_has(6);
  @$pb.TagNumber(7)
  void clearOptional() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get responseStatus => $_getSZ(7);
  @$pb.TagNumber(8)
  set responseStatus($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasResponseStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearResponseStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get comment => $_getSZ(8);
  @$pb.TagNumber(9)
  set comment($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasComment() => $_has(8);
  @$pb.TagNumber(9)
  void clearComment() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get additionalGuests => $_getIZ(9);
  @$pb.TagNumber(10)
  set additionalGuests($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAdditionalGuests() => $_has(9);
  @$pb.TagNumber(10)
  void clearAdditionalGuests() => clearField(10);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
