import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/domain/repository/save_height_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveHeightUseCase implements BaseUseCase<bool, bool, User> {
  const SaveHeightUseCase(this._useCase);
  final SaveHeightRepository _useCase;
  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(User params) async {
    final result = await _useCase.executeWithParams(params);
    return result;
  }
}
