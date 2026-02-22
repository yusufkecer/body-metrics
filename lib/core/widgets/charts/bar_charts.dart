import 'package:bodymetrics/core/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@immutable
final class BarChartWidget extends StatefulWidget {
  const BarChartWidget({
    required this.barGroups,
    required this.leftTitles,
    required this.bottomTitles,
    super.key,
  });

  final List<BarChartGroupData> barGroups;
  final List<Map<int, String>> leftTitles;
  final List<Map<int, String>> bottomTitles;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final double _barWidth = 90;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final groupCount = widget.barGroups.length;
        final availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : (MediaQuery.sizeOf(context).width - 20);

        final dynamicWidth = groupCount * _barWidth;
        final chartWidth = dynamicWidth.clamp(availableWidth, double.infinity);
        final chartHeight = availableWidth / 1.7;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: chartWidth,
            height: chartHeight,
            child: Padding(
              padding: ProductPadding.ten(),
              child: BarChart(mainBarData()),
            ),
          ),
        );
      },
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: ProductColor.instance.whiteEightTenths,
    );
    Text? text;

    for (final element in widget.bottomTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(element[value.toInt()]!, style: style);
      }
    }

    return SideTitleWidget(
      meta: meta,
      angle: -0.35,
      child: text ?? const SizedBox.shrink(),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Text? text;

    for (final element in widget.leftTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(
          element[value.toInt()]!,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: ProductColor.instance.whiteEightTenths,
          ),
          textAlign: TextAlign.left,
        );
      }
    }

    return SideTitleWidget(meta: meta, child: text ?? const SizedBox.shrink());
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) =>
              ProductColor.instance.seedColor.withAlpha(220),
          tooltipMargin: 4,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toString(),
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitleWidgets,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 10,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      alignment: BarChartAlignment.start,
      groupsSpace: 26,
      borderData: FlBorderData(show: false),
      barGroups: widget.barGroups,
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 10,
        getDrawingHorizontalLine: (_) => FlLine(
          color: ProductColor.instance.white.withAlpha(25),
          strokeWidth: 1,
          dashArray: [6, 4],
        ),
      ),
    );
  }
}
