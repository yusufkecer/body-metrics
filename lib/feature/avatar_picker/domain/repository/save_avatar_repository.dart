import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';

import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarRepository implements Repository<int, UserFilters> {
  const SaveAvatarRepository(this.userCache, this._userApiService);
  final UserCache userCache;
  final UserApiService _userApiService;

  @override
  Future<int?> executeWithParams({UserFilters? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final value = params.toJson();

    final db = await userCache.initializeDatabase();
    final result = await userCache.insert(db, value);

    try {
      final apiResult = await _userApiService.createUser(value);
      'User created on API: $apiResult'.log();
    } catch (e) {
      'Failed to sync avatar to API: $e'.e();
    }

    return result;
  }
}
