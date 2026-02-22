import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileRepository implements Repository<int, User> {
  const CreateProfileRepository(this._userCache, this._userApiService);

  final UserCache _userCache;
  final UserApiService _userApiService;

  @override
  Future<int> executeWithParams({User? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final user = params;

    final db = await _userCache.initializeDatabase();
    final userMap = user.toJson();
    'userMap $userMap'.log();
    var result = await _userCache.update(db, userMap);
    'result: $result'.log();

    if (result == 0) {
      final insertDb = await _userCache.initializeDatabase();
      result = await _userCache.insert(insertDb, userMap);
      'insert result: $result'.log();
    }

    try {
      if (user.id != null) {
        await _userApiService.updateUser(user.id!, userMap);
      }
    } catch (e) {
      'Failed to sync profile to API: $e'.e();
    }

    return result;
  }
}
