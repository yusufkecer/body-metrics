import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class AppUseCase implements BaseUseCase<Pages, bool, AppModel> {
  const AppUseCase(this._repository);
  final AppRepository _repository;

  @override

  ///Get [AppCache]
  Future<Pages> execute() async {
    final result = await _repository.execute();
    if (result.isNullOrEmpty) {
      return Pages.avatarPage;
    }
    if (result == null) return Pages.onboardPage;
    return result;
  }

  @override

  ///set [AppCache]
  Future<bool?> executeWithParams(AppModel params) async {
    final result = await _repository.executeWithParams(params);
    return result?.convertBoolResult;
  }
}
