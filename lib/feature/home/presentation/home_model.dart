part of 'home.dart';

mixin _HomeModel on TickerProviderStateMixin<Home> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

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


  void _dataListOnPressed(BuildContext context) {
    context.read<HomeCardCubit>().dataListOnPressed();
  }

  void _chartOnPressed(BuildContext context) {
    context.read<HomeCardCubit>().chartOnPressed();
  }
}
