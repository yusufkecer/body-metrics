part of '../home.dart';

@immutable
final class _PeriodSelect extends StatelessWidget {
  final HomePeriod homePeriod;
  final void Function() onYearlySelected;
  final void Function() onMonthlySelected;
  final void Function() onWeeklySelected;

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
          isSelected: homePeriod == HomePeriod.weekly,
        ),
        _Chip(
          text: LocaleKeys.home_monthly.tr(),
          onPressed: onMonthlySelected,
          isSelected: homePeriod == HomePeriod.monthly,
        ),
        _Chip(
          text: LocaleKeys.home_yearly.tr(),
          onPressed: onYearlySelected,
          isSelected: homePeriod == HomePeriod.yearly,
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final void Function() onPressed;
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
      text: text,
      onPressed: onPressed,
      borderColor: isSelected ? white : deepPurple,
      backgroundColor: isSelected ? deepPurple : white,
    );
  }
}
