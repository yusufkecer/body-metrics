import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveGenderRepository implements Repository<int, Json> {
  const SaveGenderRepository(this._userCache, this._userApiService);
  final UserCache _userCache;
  final UserApiServiceBase _userApiService;

  @override
  Future<int?> executeWithParams({Json? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _userCache.initializeDatabase();
    final result = await _userCache.update(db, params);

    try {
      final userId = params['id'] as int?;
      if (userId != null) {
        await _userApiService.updateUser(userId, params);
      }
    } catch (e) {
      'Failed to sync gender to API: $e'.w();
    }

    return result;
  }
}
