part of 'home.dart';

mixin HomeModel on State<_HomeBody> {
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

  final List<FlSpot> _spots = const [
    FlSpot(0, 120),
    FlSpot(2, 108),
    FlSpot(4, 89),
    FlSpot(6, 97),
    FlSpot(8, 78),
    FlSpot(10, 70),
    FlSpot(12, 120),
  ];

  final List<Map<int, String>> _bottomTitles = const [
    {0: 'PT'},
    {2: 'S'},
    {4: 'Ç'},
    {6: 'P'},
    {8: 'C'},
    {10: 'CT'},
    {12: 'P'},
  ];

  final List<Map<int, String>> _leftTitles = const [
    {1: '60'},
    {3: '80'},
    {5: '100'},
    {7: '120'},
    {9: '140'},
    {11: '160'},
  ];

  final UserMetrics _userMetrics = const UserMetrics(
    userMetrics: [
      UserMetric(userMetric: BodyMetricResult.normal, date: '12.12.2021', height: 180, weight: 80, bmi: 24.69),
      UserMetric(userMetric: BodyMetricResult.overweight, date: '18.12.2021', height: 180, weight: 90, bmi: 24.69),
    ],
  );
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
