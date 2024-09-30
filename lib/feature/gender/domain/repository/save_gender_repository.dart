import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveGenderRepository implements BaseUseCase<bool, int, Json> {
  final UserCache userCache = Locator.sl<UserCache>();

  @override
  Future<bool?> execute() {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  Future<int?> executeWithParams(Json gender) async {
    final db = await userCache.initializeDatabase();
    final result = await userCache.update(db, gender);
    return result;
  }
}
