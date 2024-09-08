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

  final UserMetrics _userMetrics = const UserMetrics(
    userMetrics: [
      UserMetric(userMetric: BodyMetricResult.normal, date: '12.12.2021', weight: 80, bmi: 24.69),
      UserMetric(userMetric: BodyMetricResult.overweight, date: '18.12.2021', weight: 90, bmi: 24.69),
    ],
  );
}
