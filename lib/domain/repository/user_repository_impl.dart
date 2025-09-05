import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._userCache);
  final UserCache _userCache;

  @override
  Future<User?> executeWithParams({Json? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.select(db, params);

    if (result.isNullOrEmpty || result!.users!.isEmpty) return null;
    return result.users!.first;
  }

  @override
  Future<User?> getUserWithMetrics({Json? filters}) async {
    if (filters == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();

    final join = JoinEntity(
      currentKey: UserCacheColumns.id.value,
      joinKey: UserMetricsColumns.userId.value,
      table: UserMetricsColumns.table.value,
      type: JoinType.inner.type,
    );

    final params = ParamsEntity(
      filters: filters,
      joins: [join],
    );

    final result = await _userCache.select(db, params.filters!);

    if (result.isNullOrEmpty || result!.users!.isNullOrEmpty) return null;
    return result.users!.first;
  }

  @override
  Future<Users?> getUsers({Json? filters}) async {
    final db = await _userCache.initializeDatabase();

    if (filters == null || filters.isEmpty) {
      return _userCache.selectAll(db);
    }

    return _userCache.select(db, filters);
  }

  @override
  Future<int?> saveUser({Json? data}) async {
    if (data == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    return _userCache.insert(db, data);
  }

  @override
  Future<int?> updateUser({Json? data}) async {
    if (data == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    return _userCache.update(db, data);
  }
}
