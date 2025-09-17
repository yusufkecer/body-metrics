part of '../home.dart';

final class _ChartItems {
  factory _ChartItems() {
    return _instance;
  }

  _ChartItems._internal();

  late List<FlSpot> _spots;
  late List<Map<int, String>>? _leftTitles;
  late List<Map<int, String>>? _bottomTitle;

  static final _ChartItems _instance = _ChartItems._internal();
}
