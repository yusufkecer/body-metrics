part of 'home.dart';

mixin HomeModel on State<_HomeBody> {
  String get _userName => 'John Doe';
  HomePeriod _homePeriod = HomePeriod.weekly;

  void _yearlyPeriod() {
    _homePeriod = HomePeriod.yearly;
  }

  void _monthlyPeriod() {
    _homePeriod = HomePeriod.monthly;
  }

  void _weeklyPeriod() {
    _homePeriod = HomePeriod.weekly;
  }
}

enum HomePeriod {
  weekly,
  monthly,
  yearly,
}
