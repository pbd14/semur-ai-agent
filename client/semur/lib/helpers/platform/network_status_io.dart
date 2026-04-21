import 'dart:io';

Future<bool> hasNetworkConnection() async {
  try {
    final result = await InternetAddress.lookup('firebase.google.com');
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  }
}
