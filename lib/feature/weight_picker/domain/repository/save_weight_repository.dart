import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveWeightRepository implements BaseUseCase<int, int, UserMetricEntity> {
  @override
  Future<int?>? execute() {
    throw UnimplementedError();
  }

  @override
  Future<int?> executeWithParams(UserMetricEntity params) async {
    final cache = Locator.sl<UserMetricsCache>();

    final db = await cache.initializeDatabase();

    final result = await cache.update(db, params);

    return result;
  }
}
