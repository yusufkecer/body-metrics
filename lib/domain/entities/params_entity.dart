import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';

class ParamsEntity {
  const ParamsEntity({this.columns, this.filters, this.joins});

  final List<String>? columns;
  final Json? filters;
  final List<JoinEntity>? joins;
}
