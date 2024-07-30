import 'package:logger/logger.dart';

extension LoggerExtension on dynamic {

  void logInfo([String? info]) {
    Logger().i(this, error: info);
  }

  void logWarning([String? warning]) {
    Logger().w(this, error: warning);
  }

  void logError([String? error]) {
    Logger().e(this, error: error);
  }

  void wtf([String? wtf]) {
    Logger().f(this, error: wtf);
  }
}
