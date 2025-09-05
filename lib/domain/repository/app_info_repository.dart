import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class AppInfoRepository implements Repository<Pages, AppModel> {
  const AppInfoRepository(this._appCache);

  final AppCache _appCache;

  @override
  Future<Pages?> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final column = AppCacheColumns.page.value;

    final db = await _appCache.initializeDatabase();
    final result = await _appCache.selectAll(
      db,
      columns: [column],
    );
    
    if (result.isNullOrEmpty) {
      return null;
    }

    final data = AppModel.fromJson(result);

    return data.page;
  }
}
