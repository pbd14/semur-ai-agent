import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:semur/global/log/logging.dart';

class Log {
  Log._();

  static Logger? _loggerInstance;

  static void initialize() {
    Logger.level = kDebugMode ? Level.trace : Level.off;
    _loggerInstance = Logging.instance();
  }

  // static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  //   _loggerInstance?.t(message, error: error, stackTrace: stackTrace);
  // }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance?.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance?.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance?.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance?.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.fatal].
  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerInstance?.f(message, error: error, stackTrace: stackTrace);
  }
}
