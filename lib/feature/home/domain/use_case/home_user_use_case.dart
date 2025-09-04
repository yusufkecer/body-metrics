import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/repository/home_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class HomeUserUseCase implements UseCase<User, ParamsEntity> {
  const HomeUserUseCase(this._userRepository);
  final HomeUserRepository _userRepository;

  @override
  Future<User?> executeWithParams({ParamsEntity? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final filters = params.filters;

    if (filters == null) throw ArgumentError.notNull();

    final user = await _userRepository.executeWithParams(params: filters);
    'user $user'.log();

    if (user.isNullOrEmpty || user!.users!.isEmpty) return null;

    return user.users!.first;
  }
}
