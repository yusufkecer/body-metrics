part of '../home.dart';

@immutable
final class _Chart extends StatelessWidget {
  const _Chart({
    required this.spot,
    required this.leftTitles,
    required this.bottomTitles,
    required this.onPressed,
    required this.animatedController,
  });

  final List<FlSpot> spot;
  final List<Map<int, String>> leftTitles;
  final List<Map<int, String>> bottomTitles;
  final void Function() onPressed;
  final AnimationController animatedController;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      animationController: animatedController,
      buttonTitle: LocaleKeys.home_see_more.tr(),
      onPressed: onPressed,
      title: LocaleKeys.home_chart.tr(),
      icon: ProductIcon.chart.icon,
      children: [
        LineChartWidget(spots: spot, leftTitles: leftTitles, bottomTitles: bottomTitles),
      ],
    );
  }
}
