part of 'home.dart';

mixin _HomeModel on State<_HomeBody>, _TitleMixin {
  _HomePeriod _period = _HomePeriod.weekly;

  List<Map<int, String>> _bottomTitle = [];

  _ExpandedCard _expandedCard = _ExpandedCard.none;

  @override
  void initState() {
    _bottomTitle = _bottomTitlesWeek;
    super.initState();
  }

  void _yearlyPeriod({required bool value}) {
    _period = _HomePeriod.yearly;
    setState(() {});
  }

  void _monthlyPeriod({required bool value}) {
    _period = _HomePeriod.monthly;
    _bottomTitle = _bottomTitlesMonth;
    _spots = const [
      FlSpot(0, 120),
      FlSpot(2, 108),
      FlSpot(4, 89),
      FlSpot(6, 97),
      FlSpot(8, 78),
      FlSpot(10, 70),
      FlSpot(12, 120),
      FlSpot(14, 120),
      FlSpot(16, 108),
      FlSpot(18, 89),
      FlSpot(20, 97),
      FlSpot(22, 78),
    ];

    setState(() {});
  }

  void _weeklyPeriod({required bool value}) {
    _period = _HomePeriod.weekly;
    _bottomTitle = _bottomTitlesWeek;
    setState(() {});
  }

  List<FlSpot> _spots = const [
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

  void _dataListOnPressed() {
    _expandedCard = _expandedCard == _ExpandedCard.list ? _ExpandedCard.none : _ExpandedCard.list;
    setState(() {});
  }

  void _chartOnPressed() {
    _expandedCard = _expandedCard == _ExpandedCard.chart ? _ExpandedCard.none : _ExpandedCard.chart;
    setState(() {});
  }
}
