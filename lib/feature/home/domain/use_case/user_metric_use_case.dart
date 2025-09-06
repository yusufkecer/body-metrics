import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/user_metric_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserMetricUseCase implements UseCase<UserMetrics, UserMetric> {
  const UserMetricUseCase(this._repository);
  final UserMetricRepository _repository;

  @override
  Future<UserMetrics?> executeWithParams({UserMetric? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _repository.executeWithParams(params: params);

    'UserMetricUseCase result: $result'.log();
    return result;
  }
}
