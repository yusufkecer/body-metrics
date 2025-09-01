import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashRepository
    implements BaseUseCase<AppModel, Users, ParamsEntity> {
  const SplashRepository(this._appCache, this._userCache);
  final AppCache _appCache;
  final UserCache _userCache;
  @override
  Future<AppModel?> execute() async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    if (values.isEmpty) {
      return null;
    }
    var appModel = AppModel.fromJson(values);
    if (appModel.activeUser.isNullOrEmpty) {
      //get first user from user cache
      final user = await _userCache.selectAll(db);
      if (user.isNullOrEmpty) {
        return null;
      }
      appModel = appModel.copyWith(activeUser: user?.users?.first.id);
    }
    return appModel;
  }

  @override
  Future<Users?> executeWithParams(ParamsEntity params) async {
    final columns = params.columns;
    final filters = params.filters ?? {};
    final db = await _userCache.initializeDatabase();

    return _userCache.select(db, filters, columns: columns);
  }
}
