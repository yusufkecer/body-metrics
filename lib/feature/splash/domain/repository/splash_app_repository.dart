import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashAppRepository implements Repository<AppModel, EmptyModel> {
  const SplashAppRepository(this._appCache, this._userCache);
  final AppCache _appCache;
  final UserCache _userCache;
  @override
  Future<AppModel?> executeWithParams({EmptyModel? params}) async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    if (values.isEmpty) return null;

    var appModel = AppModel.fromJson(values);

    if (appModel.activeUser.isNullOrEmpty) {
      final db = await _userCache.initializeDatabase();
      final user = await _userCache.selectAll(db);
      'user $user'.e();
      if (user.isNullOrEmpty) return null;

      appModel = appModel.copyWith(activeUser: user?.users?.first.id);
    }
    return appModel;
  }
}
