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
  final double _pointWidth = 95;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pointCount = widget.spots.length;
        final availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : (MediaQuery.sizeOf(context).width - 20);

        final dynamicWidth = pointCount * _pointWidth;
        final chartWidth = dynamicWidth.clamp(availableWidth, double.infinity);
        final chartHeight = availableWidth / 1.7;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: chartWidth,
              height: chartHeight,
              child: Padding(
                padding: ProductPadding.ten(),
                child: LineChart(avgData()),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final rounded = value.roundToDouble();
    if ((value - rounded).abs() > 0.001) {
      return const SizedBox.shrink();
    }

    final style = context.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 11,
      color: ProductColor.instance.whiteEightTenths,
    );

    Text? text;

    for (final element in widget.bottomTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(
          context.localizeDigits(element[value.toInt()]!),
          style: style,
        );
      }
    }

    return SideTitleWidget(meta: meta, child: text ?? const SizedBox.shrink());
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Text? text;

    for (final element in widget.leftTitles) {
      if (element.containsKey(value.toInt())) {
        text = Text(
          context.localizeDigits(element[value.toInt()]!),
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

  LineChartData avgData() {
    if (widget.spots.isEmpty) {
      return LineChartData();
    }

    final ys = widget.spots.map((e) => e.y);
    const minX = 0.0;
    final maxX = (widget.spots.length - 1).toDouble() + 0.1;
    final minY = ys.reduce((a, b) => a < b ? a : b) - 2;
    final maxY = ys.reduce((a, b) => a > b ? a : b) + 2;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              ProductColor.instance.seedColor.withAlpha(220),
          tooltipMargin: 8,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              return LineTooltipItem(
                context.formatDecimal(
                  barSpot.y,
                  fractionDigits: 2,
                  useGrouping: false,
                ),
                context.textTheme.bodySmall?.copyWith(
                      color: ProductColor.instance.white,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ProductColor.instance.subtleGrid,
            strokeWidth: 1,
            dashArray: [5, 4],
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ProductColor.instance.subtleGrid,
            strokeWidth: 1,
            dashArray: [5, 4],
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
        border: Border.all(color: ProductColor.instance.transparent),
      ),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ProductColor.instance.chartGradientStart,
              ProductColor.instance.chartGradientEnd,
            ],
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 3.4,
                color: ProductColor.instance.white,
                strokeWidth: 2,
                strokeColor: ProductColor.instance.chartGradientEnd,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ProductColor.instance.teal.withAlpha(70),
                ProductColor.instance.chartGradientEnd.withAlpha(15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
