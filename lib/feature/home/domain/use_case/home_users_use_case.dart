import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/home_users_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class HomeUsersUseCase implements UseCase<Users, EmptyModel> {
  const HomeUsersUseCase(this._usersRepository);
  final HomeUsersRepository _usersRepository;

  @override
  Future<Users?> executeWithParams({EmptyModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final user = await _usersRepository.executeWithParams(params: params);

    return user;
  }
}
