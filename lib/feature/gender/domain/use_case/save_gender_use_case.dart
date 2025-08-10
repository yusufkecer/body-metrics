import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/repository/save_gender_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
class SaveGenderUseCase implements BaseUseCase<bool, bool, GenderValue> {
  const SaveGenderUseCase(this._repository);
  final SaveGenderRepository _repository;

  @override
  Future<bool?> execute() {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(GenderValue gender) async {
    final user = User(gender: gender).toJson();
    final result = await _repository.executeWithParams(user);
    return result?.convertBoolResult;
  }
}
