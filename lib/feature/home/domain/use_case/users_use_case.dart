import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UsersUseCase implements BaseUseCase<Users, EmptyModel> {
  const UsersUseCase(this._usersRepository);
  final UsersRepository _usersRepository;

  @override
  Future<Users?> executeWithParams({EmptyModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final user = await _usersRepository.executeWithParams(params: params);

    return user;
  }
}
