import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/weight_picker/domain/entity/bmi_value.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CalculateBmiUseCase implements UseCase<double, BmiValue> {
  const CalculateBmiUseCase();

  @override
  Future<double> executeWithParams({BmiValue? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final weight = params.weight;
    final height = params.height;

    if (weight <= 0 || height <= 0) {
      throw ArgumentError('Weight and height must be positive values');
    }

    return weight / (height * height);
  }
}
