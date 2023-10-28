import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static void log(message, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      Logger().d(message, stackTrace);
    } else {
      // other logs goes here
      // production logs
    }
  }
}
