part of '../home.dart';

@immutable
final class _PeriodSelect extends StatelessWidget {
  final _HomePeriod homePeriod;
  final void Function({required bool value}) onYearlySelected;
  final void Function({required bool value}) onMonthlySelected;
  final void Function({required bool value}) onWeeklySelected;

  const _PeriodSelect({
    required this.homePeriod,
    required this.onYearlySelected,
    required this.onMonthlySelected,
    required this.onWeeklySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _Chip(
          text: LocaleKeys.home_weekly.tr(),
          onPressed: onWeeklySelected,
          isSelected: homePeriod == _HomePeriod.weekly,
        ),
        _Chip(
          text: LocaleKeys.home_monthly.tr(),
          onPressed: onMonthlySelected,
          isSelected: homePeriod == _HomePeriod.monthly,
        ),
        _Chip(
          text: LocaleKeys.home_yearly.tr(),
          onPressed: onYearlySelected,
          isSelected: homePeriod == _HomePeriod.yearly,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final void Function({required bool value}) onPressed;
  final bool isSelected;

  const _Chip({
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final white = ProductColor().white;
    final deepPurple = ProductColor().deepPurple;

    return ChipButton(
      isSelected: isSelected,
      text: text,
      onPressed: onPressed,
      borderColor: !isSelected ? white : deepPurple,
      backgroundColor: !isSelected ? deepPurple : white,
      textColor: !isSelected ? white : deepPurple,
    );
  }
}
