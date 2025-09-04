import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class UserRepository implements Repository<User, Json> {
  @override
  Future<User?> executeWithParams({Json? params});
  Future<Users?> getUsers({Json? filters});

  Future<User?> getUserWithMetrics({Json? filters});
  Future<int?> saveUser({Json? data});
  Future<int?> updateUser({Json? data});
}
