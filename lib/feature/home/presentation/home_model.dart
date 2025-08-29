part of 'home.dart';

mixin _HomeModel on TickerProviderStateMixin<Home>, _TitleMixin {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  _ExpandedCard _expandedCard = _ExpandedCard.none;

  late AnimationController _animatedListController;
  late AnimationController _animatedChartController;

  @override
  void initState() {
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

  final List<FlSpot> _spots = const [
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
    _expandedCard = _expandedCard == _ExpandedCard.list
        ? _ExpandedCard.none
        : _ExpandedCard.list;

    if (_expandedCard == _ExpandedCard.list) {
      _animatedListController.forward();
      _animatedChartController.reverse();
    } else {
      _animatedChartController.forward();
    }

    setState(() {});
  }

  void _chartOnPressed() {
    _expandedCard = _expandedCard == _ExpandedCard.chart
        ? _ExpandedCard.none
        : _ExpandedCard.chart;
    if (_expandedCard == _ExpandedCard.chart) {
      _animatedChartController.forward();
      _animatedListController.reverse();
    } else {
      _animatedListController.forward();
    }
    setState(() {});
  }
}
