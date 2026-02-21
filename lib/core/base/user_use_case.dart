import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class UserUseCase implements UseCase<User, ParamsEntity> {
  @override
  Future<User?> executeWithParams({ParamsEntity? params});
  Future<User?> getCurrentUser();
  Future<User?> getCurrentUserWithMetrics();
  Future<User?> getUserById(int userId);
}
