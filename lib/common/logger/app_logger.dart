import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract final class AppLogger {
  static Level logLevel = kReleaseMode ? Level.fatal : Level.debug;

  static final _logger = Logger(
    level: logLevel,
  );

  static void debug(String? message, {bool showAll = false}) {
    final formattedMessage = showAll && message != null ? _splitToNewLines(message) : message;
    _logger.d(formattedMessage);
  }

  /// handled errors crash the app
  static void error(
    Object error, {
    String? message,
    StackTrace? stackTrace,
  }) {
    _logger.i(
      message ?? 'something goes wrong',
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  /// critical errors crash the app
  static void fatal(
    Object error, {
    String? message,
    StackTrace? stackTrace,
  }) {
    _logger.f(
      message ?? 'something goes wrong',
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  static String _splitToNewLines(String message) {
    String newMessage = '';
    for (int i = 0; i < message.length; i += chunkSize) {
      final endIndex = (i + chunkSize).clamp(0, message.length);
      final newLine = i == 0 ? '' : '\n';
      newMessage += newLine + message.substring(i, endIndex);
    }
    return newMessage;
  }
}

const int chunkSize = 1024;
