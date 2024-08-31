part of 'home.dart';

mixin HomeModel on State<_HomeBody> {
  String get _userName => 'John Doe';
  HomePeriod _homePeriod = HomePeriod.weekly;

  void _yearlyPeriod() {
    _homePeriod = HomePeriod.yearly;
    setState(() {});
  }

  void _monthlyPeriod() {
    _homePeriod = HomePeriod.monthly;

    setState(() {});
  }

  void _weeklyPeriod() {
    _homePeriod = HomePeriod.weekly;
    setState(() {});
  }
}

enum HomePeriod {
  weekly,
  monthly,
  yearly,
}
