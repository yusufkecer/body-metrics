import 'package:logger/logger.dart';

extension LoggerExtension on dynamic {
  void logWarning([String? warning]) {
    Logger().w(this, error: warning);
  }

  void logError([String? error]) {
    Logger().e(this, error: error);
  }

  void log() => Logger().i(this);
  void w() => Logger().w(this);
  void e() => Logger().e(this);
}
