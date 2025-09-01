import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveHeightRepository implements BaseUseCase<bool, bool, User> {
  const SaveHeightRepository(this.userCache);
  final UserCache userCache;

  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(User params) async {
    final value = params.toJson();
    final db = await userCache.initializeDatabase();
    final result = await userCache.update(db, value);
    return result.convertBoolResult;
  }
}
