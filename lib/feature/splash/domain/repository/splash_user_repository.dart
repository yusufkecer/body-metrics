import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashUserRepository implements Repository<Users, ParamsEntity> {
  const SplashUserRepository(this._userCache, this._userApiService);
  final UserCache _userCache;
  final UserApiService _userApiService;

  @override
  Future<Users?> executeWithParams({ParamsEntity? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final columns = params.columns;
    final filters = params.filters ?? {};

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.select(db, filters, columns: columns);

    if (result != null && result.users != null && result.users!.isNotEmpty) {
      return result;
    }

    try {
      final id = filters['id'] as int?;
      if (id != null) {
        final apiResult = await _userApiService.getUserById(id);
        if (apiResult != null) {
          return Users(users: [User.fromJson(apiResult)]);
        }
      }
    } catch (e) {
      'Failed to fetch user from API in splash: $e'.e();
    }

    return result;
  }
}
