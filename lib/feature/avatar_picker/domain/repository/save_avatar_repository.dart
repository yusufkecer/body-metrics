import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';

import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarRepository implements BaseUseCase<bool, int, UserFilters> {
  final userCache = Locator.sl<UserCache>();
  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<int?> executeWithParams(UserFilters params) async {
    final value = params.toJson();
    final db = await userCache.initializeDatabase();
    return userCache.insert(db, value);
  }
}
