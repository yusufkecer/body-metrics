import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserUseCase implements BaseUseCase<Users, User, ParamsEntity> {
  const UserUseCase(this._userRepository);
  final UserRepository _userRepository;

  @override
  Future<Users?> execute() async {
    final user = await _userRepository.execute();

    return user;
  }

  @override
  Future<User?> executeWithParams(ParamsEntity params) async {
    final filters = params.filters;

    final user = await _userRepository.executeWithParams(filters!);

    if (user.isNullOrEmpty || user!.users!.isEmpty) return null;

    return user.users!.first;
  }
}
