import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class PageRepository implements BaseUseCase<String, Json> {
  final String _column = AppColumns.page.value;

  final AppCache _appCache = Locator.sl<AppCache>();

  @override
  Future<String?> execute() async {
    final db = await _appCache.initializeDatabase();
    final result = await _appCache.selectAll(
      db,
      [_column],
    );
    if (result.isNullOrEmpty) {
      return null;
    }

    final data = result[0]['page'] as String;

    return data;
  }

  @override
  Future<String?> executeWithParams(Json params) {
    throw UnimplementedError();
  }
}
