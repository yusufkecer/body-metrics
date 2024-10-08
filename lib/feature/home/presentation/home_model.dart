part of 'home.dart';

mixin _HomeModel on TickerProviderStateMixin<Home>, _TitleMixin {
  _HomePeriod _period = _HomePeriod.weekly;

  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  List<Map<int, String>> _bottomTitle = [];

  _ExpandedCard _expandedCard = _ExpandedCard.none;

  late AnimationController _animatedListController;
  late AnimationController _animatedChartController;

  late final String _userName;
  late final String _userAvatar;

  @override
  void initState() {
    _bottomTitle = _bottomTitlesWeek;
    _animatedListController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animatedChartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animatedChartController.forward();
    _animatedListController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animatedListController.dispose();
    _animatedChartController.dispose();
    _zoomDrawerController.close!();
    super.dispose();
  }

  void _yearlyPeriod({required bool value}) {
    _period = _HomePeriod.yearly;
    _bottomTitle = _bottomTitlesYear;
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

  final UserMetrics _userMetrics = UserMetrics(
    userMetrics: [
      UserMetric(
        userMetric: BodyMetricResult.normal,
        date: '12.12.2021',
        weight: 80,
        bmi: 24.69,
        weightDiff: 0,
        statusIcon: IconDataModel(
          codePoint: ProductIcon.straight.icon.codePoint,
        ),
      ),
      UserMetric(
        userMetric: BodyMetricResult.overweight,
        date: '18.12.2021',
        weight: 90,
        bmi: 24.69,
        weightDiff: 10,
        statusIcon: IconDataModel(codePoint: ProductIcon.plus.icon.codePoint),
      ),
      UserMetric(
        userMetric: BodyMetricResult.overweight,
        date: '18.12.2021',
        weight: 70,
        bmi: 24.69,
        weightDiff: 20,
        statusIcon: IconDataModel(codePoint: ProductIcon.plus.icon.codePoint),
      ),
    ],
  );

  void _dataListOnPressed() {
    _expandedCard = _expandedCard == _ExpandedCard.list ? _ExpandedCard.none : _ExpandedCard.list;

    if (_expandedCard == _ExpandedCard.list) {
      _animatedListController.forward();
      _animatedChartController.reverse();
    } else {
      _animatedChartController.forward();
    }

    setState(() {});
  }

  void _chartOnPressed() {
    _expandedCard = _expandedCard == _ExpandedCard.chart ? _ExpandedCard.none : _ExpandedCard.chart;
    if (_expandedCard == _ExpandedCard.chart) {
      _animatedChartController.forward();
      _animatedListController.reverse();
    } else {
      _animatedListController.forward();
    }
    setState(() {});
  }
}
