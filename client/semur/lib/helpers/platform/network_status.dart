import 'network_status_stub.dart'
    if (dart.library.io) 'network_status_io.dart'
    as network_status;

Future<bool> hasNetworkConnection() => network_status.hasNetworkConnection();
