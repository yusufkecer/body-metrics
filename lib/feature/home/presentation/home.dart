import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/buttons/chip_button.dart';
import 'package:bodymetrics/core/widgets/rich_text_widgets/custom_rich_text.dart';
import 'package:bodymetrics/core/widgets/space_column.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

part 'home_model.dart';
part 'mixin/title_mixin.dart';
part 'enum/period_enum.dart';
part 'widgets/chart.dart';
part 'widgets/data_list.dart';
part 'widgets/menu_view.dart';
part 'widgets/period_select.dart';
part 'enum/expanded.dart';

@immutable
@RoutePage(name: 'HomeView')
final class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with _TitleMixin, TickerProviderStateMixin, _HomeModel {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Locator.sl<UserCubit>(),
      child: Builder(
        builder: (context) {
          final userState = context.read<UserCubit>().state;
          return userState.isLoading
              ? const LoadingLottie()
              : CustomDrawer(
                  zoomDrawerController: _zoomDrawerController,
                  borderRadius: 25,
                  menuBackgroundColor: ProductColor().seedColor,
                  menuScreen: _MenuView(_userName, _userAvatar),
                  mainScreen: GradientScaffold(
                    appBar: CustomAppBar(
                      leading: IconButton(
                        onPressed: () {
                          _zoomDrawerController.toggle!();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                      title: LocaleKeys.home_hello.tr(args: [_userName]),
                    ),
                    body: _HomeBody(
                      period: _period,
                      yearlyPeriod: _yearlyPeriod,
                      monthlyPeriod: _monthlyPeriod,
                      weeklyPeriod: _weeklyPeriod,
                      dataListOnPressed: _dataListOnPressed,
                      chartOnPressed: _chartOnPressed,
                      spots: _spots,
                      leftTitles: _leftTitles,
                      bottomTitle: _bottomTitle,
                      expandedCard: _expandedCard,
                      animatedListController: _animatedListController,
                      animatedChartController: _animatedChartController,
                      userMetrics: _userMetrics,
                    ),
                  ),
                );
        },
      ),
    );
  }
}

@immutable
final class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.period,
    required this.yearlyPeriod,
    required this.monthlyPeriod,
    required this.weeklyPeriod,
    required this.dataListOnPressed,
    required this.chartOnPressed,
    required this.spots,
    required this.leftTitles,
    required this.bottomTitle,
    required this.expandedCard,
    required this.animatedListController,
    required this.animatedChartController,
    required this.userMetrics,
  });

  final _HomePeriod period;
  final void Function({required bool value}) yearlyPeriod;
  final void Function({required bool value}) monthlyPeriod;
  final void Function({required bool value}) weeklyPeriod;
  final void Function() dataListOnPressed;
  final void Function() chartOnPressed;
  final List<FlSpot> spots;
  final List<Map<int, String>> leftTitles;
  final List<Map<int, String>> bottomTitle;
  final _ExpandedCard expandedCard;
  final AnimationController animatedListController;
  final AnimationController animatedChartController;
  final UserMetrics userMetrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten().copyWith(bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _PeriodSelect(
              homePeriod: period,
              onYearlySelected: yearlyPeriod,
              onMonthlySelected: monthlyPeriod,
              onWeeklySelected: weeklyPeriod,
            ),
            _DataList(
              animatedController: animatedListController,
              userMetrics: userMetrics,
              onPressed: dataListOnPressed,
              expandedCard: expandedCard,
            ),
            VerticalSpace.s(),
            _Chart(
              animatedController: animatedChartController,
              onPressed: chartOnPressed,
              spot: spots,
              leftTitles: leftTitles,
              bottomTitles: bottomTitle,
            ),
          ],
        ),
      ),
    );
  }
}
