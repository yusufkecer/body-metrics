part of 'app_cache.dart';

enum _Table {
  theme,
  language,
  isCompletedOnboard,
  activeUser,
  page;

  String get value {
    switch (this) {
      case _Table.theme:
        return 'theme';
      case _Table.language:
        return 'language';
      case _Table.isCompletedOnboard:
        return 'is_completed_onboard';
      case _Table.activeUser:
        return 'active_user';
      case _Table.page:
        return 'page';
    }
  }
}
