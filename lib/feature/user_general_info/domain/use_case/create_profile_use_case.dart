import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/domain/repository/create_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileUseCase implements UseCase<bool, User> {
  const CreateProfileUseCase(this._repository);

  final CreateProfileRepository _repository;

  @override
  Future<bool?> executeWithParams({User? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _repository.executeWithParams(params: params);
    return result.convertBoolResult;
  }
}
