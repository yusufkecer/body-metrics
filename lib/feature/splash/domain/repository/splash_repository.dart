import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashRepository implements BaseUseCase<AppModel, Users, ParamsEntity> {
  final AppCache _appCache = Locator.sl<AppCache>();
  final UserCache _userCache = Locator.sl<UserCache>();
  @override
  Future<AppModel?> execute() async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    if (values.isEmpty) {
      return null;
    }
    final appModel = AppModel.fromJson(values.first);
    return appModel;
  }

  @override
  Future<Users?> executeWithParams(ParamsEntity params) async {
    final columns = params.columns;
    final filters = params.filters ?? {};
    final db = await _userCache.initializeDatabase();

    return _userCache.select(db, filters, columns);
  }
}
