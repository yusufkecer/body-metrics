part of '../home.dart';

@immutable
final class _LineChartCard extends StatelessWidget {
  const _LineChartCard({
    required this.spot,
    required this.leftTitles,
    required this.bottomTitles,
    required this.onPressed,
    required this.animatedController,
  });

  final List<FlSpot>? spot;
  final List<Map<int, String>>? leftTitles;
  final List<Map<int, String>>? bottomTitles;
  final void Function() onPressed;
  final AnimationController animatedController;

  @override
  Widget build(BuildContext context) {
    if (values) return const SizedBox.shrink();

    return HomeCard(
      animationController: animatedController,
      buttonTitle: LocaleKeys.home_see_more,
      onPressed: onPressed,
      showButton: false,
      title: LocaleKeys.home_line_chart,
      icon: ProductIcon.chart.icon,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SpaceValues.xs.value),
          child: Text(
            LocaleKeys.home_bmi.tr(),
            style: context.textTheme.bodySmall?.copyWith(
              color: ProductColor.instance.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        LineChartWidget(
          spots: spot!,
          leftTitles: leftTitles!,
          bottomTitles: bottomTitles!,
        ),
      ],
    );
  }

  bool get values =>
      spot.isNullOrEmpty ||
      spot!.length < 2 ||
      leftTitles.isNullOrEmpty ||
      bottomTitles.isNullOrEmpty;
}

@immutable
final class _BarChartCard extends StatelessWidget {
  const _BarChartCard({
    required this.barGroups,
    required this.leftTitles,
    required this.bottomTitles,
    required this.onPressed,
    required this.animatedController,
  });

  final List<BarChartGroupData>? barGroups;
  final List<Map<int, String>>? leftTitles;
  final List<Map<int, String>>? bottomTitles;
  final void Function() onPressed;
  final AnimationController animatedController;

  @override
  Widget build(BuildContext context) {
    if (values) return const SizedBox.shrink();

    return HomeCard(
      animationController: animatedController,
      buttonTitle: LocaleKeys.home_see_more,
      onPressed: onPressed,
      showButton: false,
      title: LocaleKeys.home_bar_chart,
      icon: ProductIcon.chart.icon,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SpaceValues.xs.value),
          child: Text(
            LocaleKeys.home_weight.tr(),
            style: context.textTheme.bodySmall?.copyWith(
              color: ProductColor.instance.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        BarChartWidget(
          barGroups: barGroups!,
          leftTitles: leftTitles!,
          bottomTitles: bottomTitles!,
        ),
      ],
    );
  }

  bool get values =>
      barGroups.isNullOrEmpty ||
      barGroups!.length < 2 ||
      leftTitles.isNullOrEmpty ||
      bottomTitles.isNullOrEmpty;
}
