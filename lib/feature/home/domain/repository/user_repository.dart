import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserRepository implements BaseUseCase<Users, Users, Json> {
  @override
  Future<Users?> execute() async {
    final cache = Locator.sl<UserCache>();

    final db = await cache.initializeDatabase();

    final result = await cache.selectAll(db);

    return result;
  }

  @override
  Future<Users?> executeWithParams(Json params) async {
    final cache = Locator.sl<UserCache>();

    final db = await cache.initializeDatabase();

    final result = await cache.select(db, params);

    return result;
  }
}
