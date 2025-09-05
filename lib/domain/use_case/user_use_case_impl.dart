import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserUseCaseImpl implements UserUseCase {
  const UserUseCaseImpl(this._userRepository);
  final UserRepositoryImpl _userRepository;

  @override
  Future<User?> executeWithParams({ParamsEntity? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final filters = params.filters;
    if (filters == null) throw ArgumentError.notNull();

    return _userRepository.executeWithParams(params: filters);
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = AppUtil.currentUserId;
    if (userId == null) return null;

    final filters = UserFilters(id: userId).toJson();
    return _userRepository.executeWithParams(params: filters);
  }

  @override
  Future<User?> getCurrentUserWithMetrics() async {
    final userId = AppUtil.currentUserId;
    if (userId == null) return null;

    final filters = UserFilters(id: userId).toJson();
    return _userRepository.getUserWithMetrics(filters: filters);
  }

  @override
  Future<User?> getUserById(int userId) async {
    final filters = UserFilters(id: userId).toJson();
    return _userRepository.executeWithParams(params: filters);
  }

  @override
  Future<Users?> getAllUsers() async {
    return _userRepository.getUsers(filters: {});
  }
}
