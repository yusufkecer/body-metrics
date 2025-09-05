part of 'app_cache.dart';

enum AppCacheColumns {
  isCompletedOnboard,
  activeUser,
  page,
  table;

  String get value {
    switch (this) {
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
