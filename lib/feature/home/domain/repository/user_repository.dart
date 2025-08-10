import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserRepository implements BaseUseCase<Users, Users, Json> {
  const UserRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<Users?> execute() async {
    final db = await _userCache.initializeDatabase();

    final result = await _userCache.selectAll(db);

    return result;
  }

  @override
  Future<Users?> executeWithParams(Json params) async {
    final db = await _userCache.initializeDatabase();

    final result = await _userCache.select(db, params);

    return result;
  }
}
