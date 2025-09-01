import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class SaveAppRepository implements BaseRepository<int, AppModel> {
  const SaveAppRepository(this._appCache);

  final AppCache _appCache;

  @override
  Future<int?> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _appCache.initializeDatabase();
    return _appCache.update(
      db,
      params.toJson(),
    );
  }
}
