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
  
  UserMetrics? _realUserMetrics;

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
    _loadUserMetrics();
    super.initState();
  }

  Future<void> _loadUserMetrics() async {
    try {
      final userMetricsCubit = Locator.sl<UserMetricsCubit>();
      await userMetricsCubit.getUserMetrics();
      
      final state = userMetricsCubit.state;
      if (state is UserMetricsLoaded) {
        _realUserMetrics = state.userMetrics;
        _updateChartData();
        setState(() {});
      } else if (state is UserMetricsEmpty) {
        'No user metrics found, using default chart data'.log();
        // Keep using fallback data
      } else if (state is UserMetricsError) {
        'Error loading user metrics: ${state.message}'.e();
        // Keep using fallback data
      }
    } catch (e) {
      'Exception loading user metrics: $e'.e();
      // Keep using fallback data if there's an error
    }
  }

  void _updateChartData() {
    if (_realUserMetrics?.userMetrics?.isNotEmpty == true) {
      _spots = _convertUserMetricsToFlSpots(_realUserMetrics!);
    }
  }

  /// Public method to refresh user metrics data
  Future<void> refreshUserMetrics() async {
    await _loadUserMetrics();
  }

  List<FlSpot> _convertUserMetricsToFlSpots(UserMetrics userMetrics) {
    final metrics = userMetrics.userMetrics ?? [];
    if (metrics.isEmpty) return _getDefaultSpots();

    final spots = <FlSpot>[];
    for (int i = 0; i < metrics.length; i++) {
      final metric = metrics[i];
      // Prefer BMI values for the chart as requested in the task
      if (metric.bmi != null && metric.bmi! > 0) {
        // Convert BMI to weight-like values for chart compatibility
        // BMI 15-40 mapped to chart range 60-135
        final scaledValue = metric.bmi! * 3 + 15; 
        spots.add(FlSpot(i.toDouble() * 2, scaledValue.clamp(60, 135)));
      } else if (metric.weight != null && metric.weight! > 0) {
        // Fallback to weight if BMI is not available
        spots.add(FlSpot(i.toDouble() * 2, metric.weight!.clamp(50, 150)));
      }
    }

    // Ensure we have at least some data points for the chart
    if (spots.isEmpty) {
      return _getDefaultSpots();
    }

    // If we have only one point, add a duplicate to make the chart work
    if (spots.length == 1) {
      spots.add(FlSpot(2, spots.first.y));
    }

    return spots;
  }

  List<FlSpot> _getDefaultSpots() {
    return const [
      FlSpot(0, 120),
      FlSpot(2, 108),
      FlSpot(4, 89),
      FlSpot(6, 97),
      FlSpot(8, 78),
      FlSpot(10, 70),
      FlSpot(12, 120),
    ];
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
    _updateChartDataForPeriod();
    setState(() {});
  }

  void _monthlyPeriod({required bool value}) {
    _period = _HomePeriod.monthly;
    _bottomTitle = _bottomTitlesMonth;
    _updateChartDataForPeriod();
    setState(() {});
  }

  void _weeklyPeriod({required bool value}) {
    _period = _HomePeriod.weekly;
    _bottomTitle = _bottomTitlesWeek;
    _updateChartDataForPeriod();
    setState(() {});
  }

  void _updateChartDataForPeriod() {
    if (_realUserMetrics?.userMetrics?.isNotEmpty == true) {
      _spots = _convertUserMetricsToFlSpots(_realUserMetrics!);
    } else {
      // Use default data based on period
      switch (_period) {
        case _HomePeriod.monthly:
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
          break;
        case _HomePeriod.weekly:
        case _HomePeriod.yearly:
          _spots = _getDefaultSpots();
          break;
      }
    }
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

  UserMetrics get userMetrics {
    return _realUserMetrics ?? _userMetrics;
  }

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
