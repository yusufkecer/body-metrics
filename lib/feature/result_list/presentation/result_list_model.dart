part of 'result_list.dart';

mixin ResultListModel on State<ResultList> {
  List<UserMetric> get _userMetricList => dataList();

  List<UserMetric> dataList() {
    if (widget.userMetrics.isNullOrEmpty || widget.userMetrics!.userMetrics!.isNullOrEmpty) return [];
    return widget.userMetrics!.userMetrics!;
  }
}
