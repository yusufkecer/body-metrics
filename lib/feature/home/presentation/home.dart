import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/chip_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'home_model.dart';
part 'widgets/data_list.dart';
part 'widgets/period_select.dart';

@immutable
@RoutePage(name: 'HomeView')
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
        title: "Hello, Jon Doe",
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
    return Padding(
      padding: ProductPadding.ten(),
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     'Hello, $_userName',
          //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //   ),
          // ),

          _PeriodSelect(
            homePeriod: _homePeriod,
            onYearlySelected: _yearlyPeriod,
            onMonthlySelected: _monthlyPeriod,
            onWeeklySelected: _weeklyPeriod,
          ),
          _DataList(
            period: 'Weekly',
          ),
        ],
      ),
    );
  }
}
