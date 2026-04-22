import 'package:flutter/foundation.dart';
// Conditionally import web plugins
import 'package:flutter_web_plugins/url_strategy.dart';

class Config {
  static const bool enableBlocDelegateDebugMessages = !kReleaseMode;
  static const bool enableHttpDebugMessages = !kReleaseMode;
  static const bool enableAnalyticsDebug = !kReleaseMode;

  static const bool devMode = false;
  static const bool useFirebaseEmulators = bool.fromEnvironment(
    'USE_FIREBASE_EMULATORS',
    defaultValue: false,
  );
  static const String firebaseEmulatorHost = String.fromEnvironment(
    'FIREBASE_EMULATOR_HOST',
    defaultValue: 'localhost',
  );

  static void setUrlStrategy() {
    if (kIsWeb) {
      // ignore: undefined_function
      usePathUrlStrategy();
    }
  }
}
