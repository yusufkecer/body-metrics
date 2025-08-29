part of '../home.dart';

mixin _TitleMixin {
  // ignore: unused_field
  final List<Map<int, String>> _bottomTitlesMonth = [
    {0: LocaleKeys.chart_month_jan.tr()},
    {2: LocaleKeys.chart_month_feb.tr()},
    {4: LocaleKeys.chart_month_mar.tr()},
    {6: LocaleKeys.chart_month_apr.tr()},
    {8: LocaleKeys.chart_month_may.tr()},
    {10: LocaleKeys.chart_month_jun.tr()},
    {12: LocaleKeys.chart_month_jul.tr()},
    {14: LocaleKeys.chart_month_aug.tr()},
    {16: LocaleKeys.chart_month_sep.tr()},
    {18: LocaleKeys.chart_month_oct.tr()},
    {20: LocaleKeys.chart_month_nov.tr()},
    {22: LocaleKeys.chart_month_dec.tr()},
  ];

  final List<Map<int, String>> _bottomTitlesWeek = [
    {0: LocaleKeys.chart_week_mon.tr()},
    {2: LocaleKeys.chart_week_tue.tr()},
    {4: LocaleKeys.chart_week_wed.tr()},
    {6: LocaleKeys.chart_week_thu.tr()},
    {8: LocaleKeys.chart_week_fri.tr()},
    {10: LocaleKeys.chart_week_sat.tr()},
    {12: LocaleKeys.chart_week_sun.tr()},
  ];

  // final List<Map<int, String>> _bottomTitlesYear = []..years;

  final List<Map<int, String>> _leftTitles = const [
    {1: '60'},
    {3: '80'},
    {5: '100'},
    {7: '120'},
    {9: '140'},
    {11: '160'},
  ];
}
