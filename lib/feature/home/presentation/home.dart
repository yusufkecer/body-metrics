import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
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
part 'widgets/chart.dart';
part 'widgets/data_list.dart';
part 'widgets/menu_view.dart';
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
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state is UserLoading
                  ? const LoadingLottie()
                  : state is UserError
                      ? CustomError(message: state.message)
                      : state is UserLoaded
                          ? CustomDrawer(
                              zoomDrawerController: _zoomDrawerController,
                              borderRadius: 25,
                              menuBackgroundColor: ProductColor.instance.seedColor,
                              menuScreen: _MenuView(
                                state.user.name!,
                                state.user.surname!,
                                state.user.avatar!,
                              ),
                              mainScreen: GradientScaffold(
                                appBar: CustomAppBar(
                                  leading: IconButton(
                                    onPressed: () {
                                      _zoomDrawerController.toggle!();
                                    },
                                    icon: const Icon(Icons.menu),
                                  ),
                                  fullName: '${state.user.name} ${state.user.surname}',
                                  title: LocaleKeys.home_hello,
                                ),
                                body: _HomeBody(
                                  dataListOnPressed: _dataListOnPressed,
                                  chartOnPressed: _chartOnPressed,
                                  spots: _spots,
                                  leftTitles: _leftTitles,
                                  bottomTitle: const [],
                                  expandedCard: _expandedCard,
                                  animatedListController: _animatedListController,
                                  animatedChartController: _animatedChartController,
                                  userMetrics: _userMetrics,
                                ),
                              ),
                            )
                          : const CustomError();
            },
          );
        },
      ),
    );
  }
}

@immutable
final class _HomeBody extends StatelessWidget {
  const _HomeBody({
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
            // _PeriodSelect(
            //   homePeriod: period,
            //   onYearlySelected: yearlyPeriod,
            //   onMonthlySelected: monthlyPeriod,
            //   onWeeklySelected: weeklyPeriod,
            // ),
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
