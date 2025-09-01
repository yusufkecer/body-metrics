import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class UsersRepository implements BaseRepository<Users, EmptyModel> {
  const UsersRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<Users?> executeWithParams({EmptyModel? params}) async {
    final db = await _userCache.initializeDatabase();

    final result = await _userCache.selectAll(db);

    return result;
  }
}
