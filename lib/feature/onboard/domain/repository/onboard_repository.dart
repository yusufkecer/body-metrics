import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class OnboardRepository implements Repository<int, AppModel> {
  const OnboardRepository(this._appCache);
  final AppCache _appCache;

  @override
  Future<int> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final db = await _appCache.initializeDatabase();
    final isComplete = (params.isCompleteOnboard ?? false) ? 1 : 0;

    final data = {
      AppCacheColumns.isCompletedOnboard.value: isComplete,
    };

    return _appCache.insert(db, data);
  }
}
