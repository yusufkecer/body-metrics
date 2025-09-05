import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/repository/save_gender_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
class SaveGenderUseCase implements UseCase<bool, GenderValue> {
  const SaveGenderUseCase(this._repository);
  final SaveGenderRepository _repository;

  @override
  Future<bool?> executeWithParams({GenderValue? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final user = User(gender: params).toJson();
    final result = await _repository.executeWithParams(params: user);
    return result?.convertBoolResult;
  }
}
