import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class AppRepository implements BaseUseCase<Pages, int, AppModel> {
  AppRepository(this._appCache);
  final String _column = AppCacheColumns.page.value;

  final AppCache _appCache;

  ///get [AppCache]
  @override
  Future<Pages?> execute() async {
    final db = await _appCache.initializeDatabase();
    final result = await _appCache.selectAll(
      db,
      columns: [_column],
    );
    if (result.isNullOrEmpty) {
      return null;
    }

    final data = result.first['page'] as String;
    return data.toPages();
  }

  ///set [AppCache]
  @override
  Future<int?> executeWithParams(AppModel params) async {
    final db = await _appCache.initializeDatabase();
    return _appCache.update(
      db,
      params.toJson(),
    );
  }
}
