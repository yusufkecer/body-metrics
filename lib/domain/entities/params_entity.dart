import 'package:bodymetrics/core/index.dart';

class ParamsEntity {
  const ParamsEntity({this.columns, this.filters});
  final List<String>? columns;
  final Json? filters;
}
