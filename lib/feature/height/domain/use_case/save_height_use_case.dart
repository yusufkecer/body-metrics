import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/domain/repository/save_height_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveHeightUseCase implements BaseUseCase<bool, User> {
  const SaveHeightUseCase(this._useCase);
  final SaveHeightRepository _useCase;

  @override
  Future<bool?> executeWithParams({User? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _useCase.executeWithParams(params: params);
    return result;
  }
}
