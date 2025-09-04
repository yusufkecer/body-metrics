import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class HomeUserRepository implements Repository<Users, Json> {
  const HomeUserRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<Users?> executeWithParams({Json? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();

    final result = await _userCache.select(db, params);

    return result;
  }
}
