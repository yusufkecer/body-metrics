import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

part 'result_list_model.dart';

@RoutePage(name: 'ResultListView')
@immutable
final class ResultList extends StatefulWidget {
  const ResultList({super.key, this.userMetrics});

  final UserMetrics? userMetrics;

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> with ResultListModel {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: const CustomAppBar(
        title: 'Result List',
      ),
      body: ListView.builder(
        itemCount: _userMetricList.length,
        itemBuilder: (context, index) {
          final userMetric = _userMetricList[index];
          return ListTile(
            title: Text(userMetric.date ?? ''),
            subtitle: Text(userMetric.weight.toString()),
            trailing: Text(userMetric.weightDiff.toString()),
          );
        },
      ),
    );
  }
}
