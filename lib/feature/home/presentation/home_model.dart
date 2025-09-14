part of 'home.dart';

mixin _HomeModel on TickerProviderStateMixin<Home> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  final _ChartItems _chartItems = _ChartItems._instance;
  _ExpandedCard _expandedCard = _ExpandedCard.none;

  late AnimationController _animatedListController;
  late AnimationController _animatedChartController;

  @override
  void initState() {
    _animatedListController = AnimationController(
      vsync: this,
      duration: Durations.long2,
    );

    _animatedChartController = AnimationController(
      vsync: this,
      duration: Durations.long2,
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

  UserMetrics? _userMetrics;

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
