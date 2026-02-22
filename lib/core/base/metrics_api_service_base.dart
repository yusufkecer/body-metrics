import 'package:bodymetrics/core/type_def.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class MetricsApiServiceBase {
  Future<Json> createMetric(int userId, Json data);
  Future<List<Json>> getMetricsByUserId(int userId);
}
