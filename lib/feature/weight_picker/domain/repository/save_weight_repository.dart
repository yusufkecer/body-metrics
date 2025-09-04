import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveWeightRepository implements Repository<int, UserMetricEntity> {
  const SaveWeightRepository(this._userMetricsCache);
  final UserMetricsCache _userMetricsCache;

  @override
  Future<int?> executeWithParams({UserMetricEntity? params}) async {
    final db = await _userMetricsCache.initializeDatabase();

    if (params == null) throw ArgumentError.notNull();

    final result = await _userMetricsCache.update(db, params);

    return result;
  }
}
