import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/bmi_cache/user_metrics_cache.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserMetricsUseCase implements BaseUseCase<UserMetrics, UserMetrics, ParamsEntity> {
  const UserMetricsUseCase(this._userMetricsCache);
  final UserMetricsCache _userMetricsCache;

  @override
  Future<UserMetrics?> execute() async {
    final db = await _userMetricsCache.initializeDatabase();
    final result = await _userMetricsCache.selectAll(db);
    return result;
  }

  @override
  Future<UserMetrics?> executeWithParams(ParamsEntity params) async {
    final db = await _userMetricsCache.initializeDatabase();
    final filters = params.filters;
    
    if (filters == null) return null;
    
    final result = await _userMetricsCache.select(db, filters);
    return result;
  }
}