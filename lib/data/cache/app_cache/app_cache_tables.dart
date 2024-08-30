part of 'app_cache.dart';

enum AppTable {
  theme,
  language,
  isCompletedOnboard,
  activeUser,
  page,
  table;

  String get value {
    switch (this) {
      case AppTable.theme:
        return 'theme';
      case AppTable.language:
        return 'language';
      case AppTable.isCompletedOnboard:
        return 'is_completed_onboard';
      case AppTable.activeUser:
        return 'active_user';
      case AppTable.page:
        return 'page';
      case AppTable.table:
        return 'app';
    }
  }
}
