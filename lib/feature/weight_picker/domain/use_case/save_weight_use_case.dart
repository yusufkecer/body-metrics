import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/feature/weight_picker/domain/repository/save_weight_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveWeightUseCase implements UseCase<bool, UserMetricEntity> {
  const SaveWeightUseCase(this._repository);
  final SaveWeightRepository _repository;

  @override
  Future<bool> executeWithParams({UserMetricEntity? params}) async {
    final result = await _repository.executeWithParams(params: params);

    return result?.convertBoolResult ?? false;
  }
}
