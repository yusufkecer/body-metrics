import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class CreateProfileRepository implements BaseUseCase<bool, int, User> {
  CreateProfileRepository() {
    _userCache = Locator.sl<UserCache>();
  }

  late final UserCache _userCache;
  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<int> executeWithParams(User user) async {
    final db = await _userCache.initializeDatabase();
    final userMap = user.toJson();
    'User Data: $userMap'.log;
    final result = _userCache.insert(db, userMap);

    return result;
  }
}
