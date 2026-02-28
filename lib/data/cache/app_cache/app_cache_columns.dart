part of 'app_cache.dart';

enum AppCacheColumns {
  isCompletedOnboard,
  activeUser,
  page,
  jwtToken,
  email,
  syncPending,
  table;

  String get value {
    switch (this) {
      case AppCacheColumns.isCompletedOnboard:
        return 'is_completed_onboard';
      case AppCacheColumns.activeUser:
        return 'active_user';
      case AppCacheColumns.page:
        return 'page';
      case AppCacheColumns.jwtToken:
        return 'jwt_token';
      case AppCacheColumns.email:
        return 'email';
      case AppCacheColumns.syncPending:
        return 'sync_pending';
      case AppCacheColumns.table:
        return 'app';
    }
  }
}
