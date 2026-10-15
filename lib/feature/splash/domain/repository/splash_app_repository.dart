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

    final appModel = AppModel.fromJson(values);

    final deleteDb = await _userCache.initializeDatabase();
    await _userCache.deleteIncomplete(deleteDb);

    final usersDb = await _userCache.initializeDatabase();
    final users = await _userCache.selectAll(usersDb);
    final userIds =
        users?.users?.map((user) => user.id).nonNulls.toList() ?? [];

    final activeUser = userIds.contains(appModel.activeUser)
        ? appModel.activeUser
        : userIds.firstOrNull;

    return AppModel(
      isCompleteOnboard: appModel.isCompleteOnboard,
      activeUser: activeUser,
    );
  }
}
