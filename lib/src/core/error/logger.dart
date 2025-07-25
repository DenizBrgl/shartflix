import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppLogger {
  static void logException(dynamic error, [StackTrace? stackTrace]) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  static void logMessage(String message) {
    FirebaseCrashlytics.instance.log(message);
  }
}
