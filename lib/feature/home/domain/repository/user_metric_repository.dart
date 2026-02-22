import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserMetricRepository
    implements Repository<UserMetrics, UserMetric> {
  const UserMetricRepository(this._userMetricsCache, this._metricsApiService);

  final UserMetricsCache _userMetricsCache;
  final MetricsApiServiceBase _metricsApiService;

  @override
  Future<UserMetrics?> executeWithParams({UserMetric? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userMetricsCache.initializeDatabase();
    final result = await _userMetricsCache.select(db, params.toJson());

    'UserMetricRepository result: $result'.log();

    try {
      if (params.userId != null) {
        final apiMetrics = await _metricsApiService.getMetricsByUserId(
          params.userId!,
        );
        if (apiMetrics.isNotEmpty) {
          'Synced ${apiMetrics.length} metrics from API'.log();
        }
      }
    } catch (e) {
      'Failed to sync metrics from API: $e'.w();
    }

    return result;
  }
}
