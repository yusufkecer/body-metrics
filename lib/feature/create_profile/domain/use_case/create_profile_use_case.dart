import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/create_profile/domain/repository/create_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileUseCase implements BaseUseCase<bool?, User> {
  final CreateProfileRepository _repository;

  const CreateProfileUseCase(this._repository);

  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<bool?> executeWithParams(User params) {
    return _repository.executeWithParams(params);
  }
}
