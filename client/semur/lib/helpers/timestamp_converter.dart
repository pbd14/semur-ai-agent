import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semur/models.pb/google/protobuf/timestamp.pb.dart' as pb;
import 'package:fixnum/fixnum.dart';

/// Converts a Protobuf Timestamp to a Firebase Timestamp.
///

// extension TimestampCustom on pb.Timestamp {
//   DateTime toDateTime() {
//     return DateTime.fromMillisecondsSinceEpoch(
//         seconds.toInt() * 1000 + nanos ~/ 1000);
//   }

//   pb.Timestamp fromDateTime(DateTime dateTime) {
//     return pb.Timestamp()
//       ..seconds = Int64(dateTime.millisecondsSinceEpoch ~/ 1000)
//       ..nanos = dateTime.microsecond * 1000;
//   }
// }

Timestamp protoToFirebaseTimestamp(pb.Timestamp protoTs) {
  return Timestamp(protoTs.seconds.toInt(), protoTs.nanos);
}

List<Timestamp> listProtoToFirebaseTimestamp(List<pb.Timestamp> protoTs) {
  return protoTs.map((ts) => Timestamp(ts.seconds.toInt(), ts.nanos)).toList();
}

pb.Timestamp firebaseToProtoTimestamp(Timestamp firebaseTs) {
  return pb.Timestamp()
    ..seconds = Int64(firebaseTs.seconds)
    ..nanos = firebaseTs.nanoseconds;
}

pb.Timestamp dateTimeToProtoTimestamp(DateTime dateTime) {
  return pb.Timestamp()
    ..seconds = Int64(dateTime.millisecondsSinceEpoch ~/ 1000)
    ..nanos = dateTime.microsecond * 1000;
}

DateTime protoToDateTime(pb.Timestamp protoTs) {
  return DateTime.fromMillisecondsSinceEpoch(
      protoTs.seconds.toInt() * 1000 + protoTs.nanos ~/ 1000);
}
