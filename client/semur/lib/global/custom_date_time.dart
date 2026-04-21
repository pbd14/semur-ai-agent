import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timezone/standalone.dart' as tz;

class CustomDateTime {
  final tz.Location location;
  CustomDateTime({required this.location});

  DateTime now() {
    return tz.TZDateTime.now(location);
  }

  // Add extension copyWith to any date time

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return tz.TZDateTime(
      location,
      year ?? now().year,
      month ?? now().month,
      day ?? now().day,
      hour ?? now().hour,
      minute ?? now().minute,
      second ?? 0,
      millisecond ?? 0,
      microsecond ?? 0,
    );
  }

  DateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    return tz.TZDateTime.fromMillisecondsSinceEpoch(
      location,
      millisecondsSinceEpoch,
    );
  }

  DateTime fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch) {
    return tz.TZDateTime.fromMicrosecondsSinceEpoch(
      location,
      microsecondsSinceEpoch,
    );
  }

  DateTime fromDateTime(DateTime dateTime) {
    DateTime adjustedDateTime = tz.TZDateTime.from(dateTime, location);
    return adjustedDateTime;
  }

  DateTime fromTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime adjustedDateTime = tz.TZDateTime.from(dateTime, location);
    return adjustedDateTime;
  }
}
