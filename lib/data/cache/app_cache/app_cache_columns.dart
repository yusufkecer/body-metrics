part of 'app_cache.dart';

enum AppColumns {
  theme,
  language,
  isCompletedOnboard,
  activeUser,
  page,
  table;

  String get value {
    switch (this) {
      case AppColumns.theme:
        return 'theme';
      case AppColumns.language:
        return 'language';
      case AppColumns.isCompletedOnboard:
        return 'is_completed_onboard';
      case AppColumns.activeUser:
        return 'active_user';
      case AppColumns.page:
        return 'page';
      case AppColumns.table:
        return 'app';
    }
  }
}
