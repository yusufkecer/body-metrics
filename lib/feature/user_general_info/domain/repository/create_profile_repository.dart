import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileRepository implements BaseUseCase<bool, int, User> {
  const CreateProfileRepository(this._userCache);

  final UserCache _userCache;
  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<int> executeWithParams(User user) async {
    final db = await _userCache.initializeDatabase();
    final userMap = user.toJson();
    'userMap $userMap'.log();
    final result = await _userCache.update(db, userMap);
    'result: $result'.log();
    return result;
  }
}
