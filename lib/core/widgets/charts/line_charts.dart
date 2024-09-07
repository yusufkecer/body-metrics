import 'package:bodymetrics/core/index.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

@immutable
final class LineChartWidget extends StatefulWidget {
  final List<FlSpot> spots;
  final List<Map<int, String>> titles;
  final List<Map<int, String>> bottomTitles;
  const LineChartWidget({
    required this.spots,
    required this.titles,
    required this.bottomTitles,
    super.key,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: ProductPadding.ten(),
            child: LineChart(
              avgData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    Text? text;

    for (final element in widget.bottomTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(
          element[value.toInt()]!,
          style: style,
        );
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text ?? const SizedBox.shrink(),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Text? text;

    for (final element in widget.titles) {
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

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text ?? const SizedBox.shrink(),
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ProductColor().white,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ProductColor().white,
            strokeWidth: 1,
          );
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
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 120.calculateEquation),
            FlSpot(2, 108.calculateEquation),
            FlSpot(4, 89.calculateEquation),
            FlSpot(6, 97.calculateEquation),
            FlSpot(8, 78.calculateEquation),
            FlSpot(10, 70.calculateEquation),
            FlSpot(12, 120.calculateEquation),
          ],
          isCurved: true,
          color: ProductColor().white,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: ProductColor().backgroundColorList,
            ),
          ),
        ),
      ],
    );
  }
}

extension _CalculateEquation on num {
  double get calculateEquation {
    return (this - 50) / 10;
  }
}
