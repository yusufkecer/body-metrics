import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/repository/save_avatar_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarUseCase implements BaseUseCase<bool, int, UserFilters> {
  const SaveAvatarUseCase(this._useCase);
  final SaveAvatarRepository _useCase;
  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<int?> executeWithParams(UserFilters params) async {
    final result = await _useCase.executeWithParams(params);
    return result;
  }
}
