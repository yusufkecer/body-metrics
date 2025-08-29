import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveGenderRepository implements BaseUseCase<bool, int, Json> {
  const SaveGenderRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<int?> executeWithParams(Json gender) async {
    final db = await _userCache.initializeDatabase();
    final result = await _userCache.update(db, gender);
    return result;
  }
}
