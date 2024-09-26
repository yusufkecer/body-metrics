import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/avatar_picker/domain/repository/save_avatar_repository.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarUseCase implements BaseUseCase<bool, bool, UserFilters> {
  final useCase = Locator.sl<SaveAvatarRepository>();
  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(UserFilters params) async {
    final result = await useCase.executeWithParams(params);
    return result?.convertBoolResult;
  }
}
