part of 'home.dart';

mixin _HomeModel on TickerProviderStateMixin<Home> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  late AnimationController _animatedListController;
  late AnimationController _animatedLineChartController;
  late AnimationController _animatedBarChartController;

  @override
  void initState() {
    super.initState();

    _animatedListController = AnimationController(
      vsync: this,
      duration: Durations.long2,
    );

    _animatedLineChartController = AnimationController(
      vsync: this,
      duration: Durations.long2,
    );

    _animatedBarChartController = AnimationController(
      vsync: this,
      duration: Durations.long2,
    );

    _animatedLineChartController.forward();
    _animatedBarChartController.forward();
    _animatedListController.forward();
  }

  @override
  void dispose() {
    _animatedListController.dispose();
    _animatedLineChartController.dispose();
    _animatedBarChartController.dispose();
    _zoomDrawerController.close?.call();
    super.dispose();
  }

  void _dataListOnPressed(BuildContext context) {
    context.read<HomeCardCubit>().dataListOnPressed();
  }

  void _lineChartOnPressed(BuildContext context) {
    context.read<HomeCardCubit>().chartOnPressed();
  }

  void _barChartOnPressed(BuildContext context) {
    context.read<HomeCardCubit>().chartOnPressed();
  }
}
