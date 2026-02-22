import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._userCache, this._userApiService);
  final UserCache _userCache;
  final UserApiServiceBase _userApiService;

  @override
  Future<User?> executeWithParams({Json? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.select(db, params);

    if (result?.users?.isNotEmpty ?? false) {
      return result!.users!.first;
    }

    try {
      final id = params['id'] as int?;
      if (id != null) {
        final apiResult = await _userApiService.getUserById(id);
        if (apiResult != null) {
          return User.fromJson(apiResult);
        }
      }
    } catch (e) {
      'Failed to fetch user from API: $e'.w();
    }

    return null;
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

    final params = ParamsEntity(filters: filters, joins: [join]);

    final result = await _userCache.select(db, params.filters!);

    return result?.users?.firstOrNull;
  }

  @override
  Future<int?> saveUser({Json? data}) async {
    if (data == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.insert(db, data);

    try {
      await _userApiService.createUser(data);
    } catch (e) {
      'Failed to sync user to API: $e'.w();
    }

    return result;
  }

  @override
  Future<int?> updateUser({Json? data}) async {
    if (data == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.update(db, data);

    try {
      final id = data['id'] as int?;
      if (id != null) {
        await _userApiService.updateUser(id, data);
      }
    } catch (e) {
      'Failed to sync user update to API: $e'.w();
    }

    return result;
  }
}
