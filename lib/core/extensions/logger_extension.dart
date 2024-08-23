import 'package:logger/logger.dart';

extension LoggerExtension on dynamic {
  void logWarning([String? warning]) {
    Logger().w(this, error: warning);
  }

  void logError([String? error]) {
    Logger().e(this, error: error);
  }

  dynamic get log => Logger().i(this);
  dynamic get w => Logger().w(this);
  dynamic get e => Logger().e(this);
}
