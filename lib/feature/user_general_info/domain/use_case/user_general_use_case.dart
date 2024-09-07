import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/domain/repository/user_general_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileUseCase implements BaseUseCase<bool?, User> {
  const CreateProfileUseCase(this._repository);

  final CreateProfileRepository _repository;

  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<bool?> executeWithParams(User params) {
    return _repository.executeWithParams(params);
  }
}
