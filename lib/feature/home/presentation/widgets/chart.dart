part of '../home.dart';

class _Chart extends StatelessWidget {
  const _Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return _CardWidget(
      buttonTitle: LocaleKeys.home_see_more.tr(),
      onPressed: () {
        'Button pressed'.log;
      },
      title: LocaleKeys.home_chart.tr(),
      icon: ProductIcon.chart.icon,
      children: const [
        _CustomChart(),
      ],
    );
  }
}

class _CustomChart extends StatefulWidget {
  const _CustomChart({super.key});

  @override
  State<_CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<_CustomChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
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
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('PT', style: style);
      case 2:
        text = const Text('S', style: style);
      case 4:
        text = const Text('Ç', style: style);
      case 6:
        text = const Text('P', style: style);
      case 8:
        text = const Text('C', style: style);
      case 10:
        text = const Text('CT', style: style);
      case 12:
        text = const Text('P', style: style);
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '60';
      case 3:
        text = '80';
      case 5:
        text = '100';
      case 7:
        text = '120';
      case 9:
        text = '140';

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
            FlSpot(0, 120.toDouble().calculateEquation),
            FlSpot(2, 108.toDouble().calculateEquation),
            FlSpot(4, 89.toDouble().calculateEquation),
            FlSpot(6, 97.toDouble().calculateEquation),
            FlSpot(8, 78.toDouble().calculateEquation),
            FlSpot(10, 70.toDouble().calculateEquation),
            FlSpot(12, 120.toDouble().calculateEquation),
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

extension _CalculateEquation on double {
  double get calculateEquation {
    return (this - 50) / 10;
  }
}
