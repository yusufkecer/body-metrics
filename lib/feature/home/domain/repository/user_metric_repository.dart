import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserMetricRepository implements Repository<UserMetrics, UserMetric> {
  const UserMetricRepository(this._userMetricsCache);
  final UserMetricsCache _userMetricsCache;

  @override
  Future<UserMetrics?> executeWithParams({UserMetric? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userMetricsCache.initializeDatabase();
    final result = await _userMetricsCache.select(db, params.toJson());

    'UserMetricRepository result: $result'.log();
    return result;
  }
}
