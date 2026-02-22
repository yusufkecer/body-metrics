import 'package:bodymetrics/core/index.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@immutable
final class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    required this.spots,
    required this.leftTitles,
    required this.bottomTitles,
    super.key,
  });

  final List<FlSpot> spots;
  final List<Map<int, String>> leftTitles;
  final List<Map<int, String>> bottomTitles;

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final double _pointWidth = 150;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pointCount = widget.spots.length;
        final screenWidth = constraints.maxWidth;

        final dynamicWidth = pointCount * _pointWidth;
        final chartWidth = dynamicWidth.clamp(screenWidth, double.infinity);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: chartWidth,
            height: screenWidth / 1.70,
            child: Padding(
              padding: ProductPadding.ten(),
              child: LineChart(avgData()),
            ),
          ),
        );
      },
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);

    Text? text;

    for (final element in widget.bottomTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(element[value.toInt()]!, style: style);
      }
    }

    return SideTitleWidget(meta: meta, child: text ?? const SizedBox.shrink());
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Text? text;

    for (final element in widget.leftTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(
          element[value.toInt()]!,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        );
      }
    }

    return SideTitleWidget(meta: meta, child: text ?? const SizedBox.shrink());
  }

  LineChartData avgData() {
    if (widget.spots.isEmpty) {
      return LineChartData();
    }

    final ys = widget.spots.map((e) => e.y);
    const minX = 0.0;
    final maxX = (widget.spots.length - 1).toDouble();
    final minY = ys.reduce((a, b) => a < b ? a : b) - 2;
    final maxY = ys.reduce((a, b) => a > b ? a : b) + 2;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              ProductColor.instance.lightPurple.withAlpha(200),
          tooltipMargin: 8,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                barSpot.y.toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(color: ProductColor.instance.white, strokeWidth: 1);
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(color: ProductColor.instance.white, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          color: ProductColor.instance.white,
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: ProductColor.instance.backgroundColorList,
            ),
          ),
        ),
      ],
    );
  }
}
