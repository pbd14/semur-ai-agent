import 'package:flutter/foundation.dart';
// Conditionally import web plugins
import 'package:flutter_web_plugins/url_strategy.dart';

class Config {
  static const bool enableBlocDelegateDebugMessages = !kReleaseMode;
  static const bool enableHttpDebugMessages = !kReleaseMode;
  static const bool enableAnalyticsDebug = !kReleaseMode;

  static const bool devMode = false;

  static void setUrlStrategy() {
    if (kIsWeb) {
      // ignore: undefined_function
      usePathUrlStrategy();
    }
  }
}
