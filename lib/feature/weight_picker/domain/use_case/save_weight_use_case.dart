import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/weight_picker/domain/repository/save_weight_repository.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveWeightUseCase implements BaseUseCase<int, bool, UserMetrics> {
  @override
  Future<int?>? execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(UserMetrics params) async {
    final repository = Locator.sl<SaveWeightRepository>();
    final data = params.toJson();
    final result = await repository.executeWithParams(data);

    return result;
  }
}
