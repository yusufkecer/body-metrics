import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class PageRepository implements BaseUseCase<String, int, AppModel> {
  final String _column = AppCacheColumns.page.value;

  final AppCache _appCache = Locator.sl<AppCache>();

  @override

  ///Get the current page from the cache
  Future<String?> execute() async {
    final db = await _appCache.initializeDatabase();
    final result = await _appCache.selectAll(
      db,
      [_column],
    );
    if (result.isNullOrEmpty) {
      return null;
    }

    final data = result.first['page'] as String;

    return data;
  }

  @override

  ///Set the current page to the cache
  Future<int?> executeWithParams(AppModel params) async {
    final db = await _appCache.initializeDatabase();
    return _appCache.update(
      db,
      params.toJson(),
    );
  }
}
