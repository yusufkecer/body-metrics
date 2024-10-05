import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache_columns.dart';

import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/splash/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashUseCase implements BaseUseCase<AppModel, User, ParamsEntity> {
  final SplashRepository _splashRepository = Locator.sl<SplashRepository>();

  @override
  Future<AppModel?> execute() {
    return _splashRepository.execute();
  }

  @override
  Future<User?> executeWithParams(ParamsEntity params) async {
    final value = await _splashRepository.executeWithParams(params);

    if (value.isNullOrEmpty || value!.users is! List) {
      return null;
    }

    final column = params.columns;

    if (column.isNullOrEmpty) {
      return null;
    }

    if (column!.contains(UserCacheColumns.avatar.value)) {
      return User(avatar: value.users?.first.avatar);
    }
    if (column.contains(UserCacheColumns.gender.value)) {
      return User(gender: value.users?.first.gender);
    }

    return null;
  }
}
