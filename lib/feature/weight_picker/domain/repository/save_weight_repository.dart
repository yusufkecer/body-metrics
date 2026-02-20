import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveWeightRepository implements Repository<int, UserMetric> {
  const SaveWeightRepository(this._userMetricsCache);
  final UserMetricsCache _userMetricsCache;

  @override
  Future<int?> executeWithParams({UserMetric? params}) async {
    final db = await _userMetricsCache.initializeDatabase();

    if (params == null) throw ArgumentError.notNull();

    final result = await _userMetricsCache.insert(db, params);

    return result;
  }
}
