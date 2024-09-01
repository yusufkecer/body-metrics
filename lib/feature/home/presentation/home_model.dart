part of 'home.dart';

mixin HomeModel on State<_HomeBody> {
  String get _userName => 'John Doe';
  _HomePeriod _period = _HomePeriod.weekly;

  void _yearlyPeriod({required bool value}) {
    _period = _HomePeriod.yearly;
    setState(() {});
  }

  void _monthlyPeriod({required bool value}) {
    _period = _HomePeriod.monthly;

    setState(() {});
  }

  void _weeklyPeriod({required bool value}) {
    _period = _HomePeriod.weekly;
    setState(() {});
  }
}

enum _HomePeriod {
  weekly,
  monthly,
  yearly;

  String get name {
    switch (this) {
      case _HomePeriod.weekly:
        return LocaleKeys.home_weekly.tr();
      case _HomePeriod.monthly:
        return LocaleKeys.home_monthly.tr();
      case _HomePeriod.yearly:
        return LocaleKeys.home_yearly.tr();
    }
  }
}
