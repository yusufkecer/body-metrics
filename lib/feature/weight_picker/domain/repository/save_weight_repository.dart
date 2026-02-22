import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
@immutable
final class SaveWeightRepository implements Repository<int, UserMetric> {
  const SaveWeightRepository(
    this._userMetricsCache,
    this._metricsApiService,
  );

  final UserMetricsCache _userMetricsCache;
  final MetricsApiService _metricsApiService;

  @override
  Future<int?> executeWithParams({UserMetric? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userMetricsCache.initializeDatabase();
    final weightDiff = await _computeWeightDiff(db, params);
    final metric = params.copyWith(
      weightDiff: double.parse(weightDiff.toStringAsFixed(2)),
    );

    final result = await _userMetricsCache.insert(db, metric);

    try {
      if (metric.userId != null) {
        await _metricsApiService.createMetric(
          metric.userId!,
          metric.toJson(),
        );
      }
    } catch (e) {
      'Failed to sync metric to API: $e'.e();
    }

    return result;
  }

  Future<double> _computeWeightDiff(Database? db, UserMetric metric) async {
    final currentWeight = metric.weight ?? 0;
    if (db == null || metric.userId == null) return currentWeight;

    final rows = await db.query(
      _userMetricsCache.table,
      columns: [UserMetricsColumns.weight.value],
      where: '${UserMetricsColumns.userId.value} = ?',
      whereArgs: [metric.userId],
      orderBy:
          '${UserMetricsColumns.createdAt.value} DESC, ${UserMetricsColumns.id.value} DESC',
      limit: 1,
    );

    if (rows.isEmpty) return currentWeight;

    final lastWeight =
        (rows.first[UserMetricsColumns.weight.value] as num?)?.toDouble();
    if (lastWeight == null) return currentWeight;

    return currentWeight - lastWeight;
  }
}
