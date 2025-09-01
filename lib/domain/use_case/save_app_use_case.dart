import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/repository/save_app_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveAppUseCase implements BaseUseCase<bool, AppModel> {
  const SaveAppUseCase(this._repository);
  final SaveAppRepository _repository;

  @override
  Future<bool?> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _repository.executeWithParams(params: params);
    return result?.convertBoolResult;
  }
}
