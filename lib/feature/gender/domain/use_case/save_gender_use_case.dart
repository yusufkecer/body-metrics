import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/repository/save_gender_repository.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
class SaveGenderUseCase implements BaseUseCase<bool, bool, GenderValue> {
  final SaveGenderRepository repository = Locator.sl<SaveGenderRepository>();

  @override
  Future<bool?> execute() {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(GenderValue gender) async {
    final user = User(gender: gender).toJson();
    final result = await repository.executeWithParams(user);
    return result?.convertBoolResult;
  }
}
