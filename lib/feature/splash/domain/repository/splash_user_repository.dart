import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashUserRepository implements BaseRepository<Users, ParamsEntity> {
  const SplashUserRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<Users?> executeWithParams({ParamsEntity? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final columns = params.columns;
    final filters = params.filters ?? {};
    final db = await _userCache.initializeDatabase();

    final result = await _userCache.select(db, filters, columns: columns);
    return result;
  }
}
