import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/chip_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'home_model.dart';
part 'widgets/data_list.dart';
part 'widgets/period_select.dart';

@immutable
final class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.home.tr(),
      ),
      body: const _HomeBody(),
    );
  }
}

@immutable
final class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => __HomeBodyState();
}

class __HomeBodyState extends State<_HomeBody> with HomeModel {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello, $_userName'),
          _PeriodSelect(
            homePeriod: _homePeriod,
            onYearlySelected: _yearlyPeriod,
            onMonthlySelected: _monthlyPeriod,
            onWeeklySelected: _weeklyPeriod,
          ),
        ],
      ),
    );
  }
}
