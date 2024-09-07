part of '../home.dart';

@immutable
final class _Chart extends StatelessWidget {
  final List<FlSpot> spot;
  final List<Map<int, String>> leftTitles;
  final List<Map<int, String>> bottomTitles;
  const _Chart({required this.spot, required this.leftTitles, required this.bottomTitles});

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      buttonTitle: LocaleKeys.home_see_more.tr(),
      onPressed: () {
        'Button pressed'.log;
      },
      title: LocaleKeys.home_chart.tr(),
      icon: ProductIcon.chart.icon,
      children: [
        LineChartWidget(spots: spot, leftTitles: leftTitles, bottomTitles: bottomTitles),
      ],
    );
  }
}
