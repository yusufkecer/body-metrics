import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveHeightRepository implements Repository<bool, User> {
  const SaveHeightRepository(this.userCache);
  final UserCache userCache;

  @override
  Future<bool?> executeWithParams({User? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final value = params.toJson();
    final db = await userCache.initializeDatabase();
    final result = await userCache.update(db, value);
    return result.convertBoolResult;
  }
}
