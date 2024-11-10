import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/user_repository.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserUseCase implements BaseUseCase<Users, User, ParamsEntity> {
  @override
  Future<Users?> execute() async {
    final userRepository = Locator.sl<UserRepository>();

    final user = await userRepository.execute();

    return user;
  }

  @override
  Future<User?> executeWithParams(ParamsEntity params) async {
    final userRepository = Locator.sl<UserRepository>();

    final filters = params.filters;

    final user = await userRepository.executeWithParams(filters!);

    if (user.isNullOrEmpty || user!.users!.isEmpty) return null;

    return user.users!.first;
  }
}
