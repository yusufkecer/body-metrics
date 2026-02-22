import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveAppRepository implements Repository<int, AppModel> {
  const SaveAppRepository(this._appCache);

  final AppCache _appCache;

  @override
  Future<int?> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _appCache.initializeDatabase();
    final updated = await _appCache.update(db, params.toJson());
    if (updated > 0) return updated;

    return _appCache.insert(db, params.toJson());
  }
}
