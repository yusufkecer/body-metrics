import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/rich_text_widgets/custom_rich_text.dart';
import 'package:bodymetrics/core/widgets/space_column.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart';
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

@immutable
@RoutePage(name: 'HomeView')
final class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin, _HomeModel {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => Locator.sl<UserCubit>(),
        ),
        BlocProvider<UserMetricCubit>(
          create: (_) => Locator.sl<UserMetricCubit>(),
        ),
        BlocProvider<HomeCardCubit>(
          create: (_) => Locator.sl<HomeCardCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return switch (state) {
                UserLoading() => const LoadingLottie(),
                UserError() => CustomError(message: state.message),
                UserLoaded() => customDrawer(state),
                _ => const CustomError(),
              };
            },
          );
        },
      ),
    );
  }

  CustomDrawer customDrawer(UserLoaded state) {
    return CustomDrawer(
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
        ),
        body: BlocBuilder<UserMetricCubit, UserMetricState>(
          builder: (context, homeCardState) {
            return _HomeBody(
              dataListOnPressed: () => _dataListOnPressed(context),
              chartOnPressed: () => _chartOnPressed(context),
              spots: _chartItems._spots,
              leftTitles: _chartItems._leftTitles,
              bottomTitle: _chartItems._bottomTitle,
              animatedListController: _animatedListController,
              animatedChartController: _animatedChartController,
              userMetrics: _userMetrics,
            );
          },
        ),
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
    required this.animatedListController,
    required this.animatedChartController,
    required this.userMetrics,
  });

  final void Function() dataListOnPressed;
  final void Function() chartOnPressed;
  final List<FlSpot>? spots;
  final List<Map<int, String>>? leftTitles;
  final List<Map<int, String>>? bottomTitle;
  final AnimationController animatedListController;
  final AnimationController animatedChartController;
  final UserMetrics? userMetrics;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCardCubit, HomeCardState>(
      builder: (context, state) {
        final expandedCard =
            state is HomeCardLoaded ? state.expandedCard : ExpandedCard.none;
        return Padding(
          padding: ProductPadding.ten().copyWith(bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
      },
    );
  }
}
