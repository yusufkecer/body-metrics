import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class OnboardRepository implements BaseUseCase<bool, int, AppModel> {
  const OnboardRepository(this._userCache);
  final UserCache _userCache;

  @override
  Future<bool> execute() {
    throw UnimplementedError();
  }

  @override
  Future<int> executeWithParams(AppModel params) async {
    final db = await _userCache.initializeDatabase();
    final isComplete = (params.isCompleteOnboard ?? false) ? 1 : 0;

    final data = {
      AppCacheColumns.isCompletedOnboard.value: isComplete,
    };

    return _userCache.insert(db, data);
  }
}
