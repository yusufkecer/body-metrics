import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/rich_text_widgets/custom_rich_text.dart';
import 'package:bodymetrics/core/widgets/space_column.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/auth_session_cubit.dart';
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
        BlocProvider<UserCubit>(create: (_) => Locator.sl<UserCubit>()),
        BlocProvider<UserMetricCubit>(
          create: (_) {
            final cubit = Locator.sl<UserMetricCubit>();
            final userId = AppUtil.currentUserId;
            if (userId != null) {
              cubit.getUserMetric(userId);
            }
            return cubit;
          },
        ),
        BlocProvider<HomeCardCubit>(create: (_) => Locator.sl<HomeCardCubit>()),
        BlocProvider<AuthSessionCubit>(
          create: (_) => Locator.sl<AuthSessionCubit>()..loadSession(),
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
          title: AppUtil.appName,
          leading: IconButton(
            onPressed: () {
              _zoomDrawerController.toggle!();
            },
            icon: const Icon(Icons.menu),
          ),
          action: Container(
            margin: EdgeInsets.only(right: SpaceValues.xs.value),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProductColor.instance.white.withAlpha(30),
              border: Border.all(color: ProductColor.instance.cardBorder),
            ),
            child: IconButton(
              onPressed: () async {
                await context.router.push(const WeightView());
              },
              icon: Icon(Icons.add_rounded, color: ProductColor.instance.white),
            ),
          ),
        ),
        body: BlocBuilder<UserMetricCubit, UserMetricState>(
          builder: (context, homeCardState) {
            final userMetrics = switch (homeCardState) {
              UserMetricSuccess() => homeCardState.userMetric,
              _ => null,
            };

            return _HomeBody(
              dataListOnPressed: () => _dataListOnPressed(context),
              lineChartOnPressed: () => _lineChartOnPressed(context),
              barChartOnPressed: () => _barChartOnPressed(context),
              spots: _buildSpots(userMetrics),
              barGroups: _buildBarGroups(userMetrics),
              lineLeftTitles: _buildLineLeftTitles(userMetrics),
              barLeftTitles: _buildBarLeftTitles(userMetrics),
              bottomTitle: _buildBottomTitles(userMetrics),
              animatedListController: _animatedListController,
              animatedLineChartController: _animatedLineChartController,
              animatedBarChartController: _animatedBarChartController,
              userMetrics: userMetrics,
            );
          },
        ),
      ),
    );
  }

  List<FlSpot>? _buildSpots(UserMetrics? userMetrics) {
    final values = userMetrics?.userMetrics
        ?.where((metric) => metric.bmi != null)
        .toList();

    if (values.isNullOrEmpty) return null;

    return values!
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.bmi!))
        .toList();
  }

  List<BarChartGroupData>? _buildBarGroups(UserMetrics? userMetrics) {
    final values = userMetrics?.userMetrics
        ?.where((metric) => metric.weight != null)
        .toList();

    if (values.isNullOrEmpty) return null;

    return values!
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.weight!,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ProductColor.instance.teal,
                    ProductColor.instance.chartGradientEnd,
                  ],
                ),
                width: 16,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(SpaceValues.s.value),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  List<Map<int, String>>? _buildLineLeftTitles(UserMetrics? userMetrics) {
    final values = userMetrics?.userMetrics
        ?.where((metric) => metric.bmi != null)
        .map((metric) => metric.bmi!.round())
        .toSet()
        .toList();

    if (values.isNullOrEmpty) return null;

    values!.sort();
    return values.map((value) => {value: value.toString()}).toList();
  }

  List<Map<int, String>>? _buildBarLeftTitles(UserMetrics? userMetrics) {
    final values = userMetrics?.userMetrics
        ?.where((metric) => metric.weight != null)
        .map((metric) => metric.weight!.round())
        .toSet()
        .toList();

    if (values.isNullOrEmpty) return null;

    values!.sort();
    return values.map((value) => {value: value.toString()}).toList();
  }

  List<Map<int, String>>? _buildBottomTitles(UserMetrics? userMetrics) {
    final values = userMetrics?.userMetrics
        ?.where((metric) => metric.bmi != null)
        .toList();

    if (values.isNullOrEmpty) return null;

    return values!
        .asMap()
        .entries
        .map(
          (entry) => {
            entry.key: _toChartDateLabel(
              entry.value,
              fallback: '${entry.key + 1}',
            ),
          },
        )
        .toList();
  }

  String _toChartDateLabel(UserMetric metric, {required String fallback}) {
    final createdAt = metric.createdAt;
    if (createdAt.isNullOrEmpty) {
      return metric.date?.split('-').take(2).join('/') ?? fallback;
    }

    final parsed = DateTime.tryParse(createdAt!);
    if (parsed == null) {
      return metric.date?.split('-').take(2).join('/') ?? fallback;
    }

    return DateFormat('dd/MM').format(parsed);
  }
}

@immutable
final class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.dataListOnPressed,
    required this.lineChartOnPressed,
    required this.barChartOnPressed,
    required this.spots,
    required this.barGroups,
    required this.lineLeftTitles,
    required this.barLeftTitles,
    required this.bottomTitle,
    required this.animatedListController,
    required this.animatedLineChartController,
    required this.animatedBarChartController,
    required this.userMetrics,
  });

  final void Function() dataListOnPressed;
  final void Function() lineChartOnPressed;
  final void Function() barChartOnPressed;
  final List<FlSpot>? spots;
  final List<BarChartGroupData>? barGroups;
  final List<Map<int, String>>? lineLeftTitles;
  final List<Map<int, String>>? barLeftTitles;
  final List<Map<int, String>>? bottomTitle;
  final AnimationController animatedListController;
  final AnimationController animatedLineChartController;
  final AnimationController animatedBarChartController;
  final UserMetrics? userMetrics;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCardCubit, HomeCardState>(
      builder: (context, state) {
        final expandedCard = state is HomeCardLoaded
            ? state.expandedCard
            : ExpandedCard.none;
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
                _LineChartCard(
                  animatedController: animatedLineChartController,
                  onPressed: lineChartOnPressed,
                  spot: spots,
                  leftTitles: lineLeftTitles,
                  bottomTitles: bottomTitle,
                ),
                VerticalSpace.s(),
                _BarChartCard(
                  animatedController: animatedBarChartController,
                  onPressed: barChartOnPressed,
                  barGroups: barGroups,
                  leftTitles: barLeftTitles,
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
