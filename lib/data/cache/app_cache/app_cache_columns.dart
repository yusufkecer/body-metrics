part of 'app_cache.dart';

enum AppCacheColumns {
  theme,
  language,
  isCompletedOnboard,
  activeUser,
  page,
  table;

  String get value {
    switch (this) {
      case AppCacheColumns.theme:
        return 'theme';
      case AppCacheColumns.language:
        return 'language';
      case AppCacheColumns.isCompletedOnboard:
        return 'is_completed_onboard';
      case AppCacheColumns.activeUser:
        return 'active_user';
      case AppCacheColumns.page:
        return 'page';
      case AppCacheColumns.table:
        return 'app';
    }
  }
}
