import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/repository/save_avatar_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarUseCase implements UseCase<int, UserFilters> {
  const SaveAvatarUseCase(this._useCase);
  final SaveAvatarRepository _useCase;

  @override
  Future<int?> executeWithParams({UserFilters? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _useCase.executeWithParams(params: params);

    if (result == 0) return null;

    return result;
  }
}
