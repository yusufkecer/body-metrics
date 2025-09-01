import 'package:bodymetrics/core/index.dart';

import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/splash/domain/repository/splash_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashUserUseCase implements BaseUseCase<User, ParamsEntity> {
  const SplashUserUseCase(this._splashRepository);
  final SplashUserRepository _splashRepository;

  @override
  Future<User?> executeWithParams({ParamsEntity? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final value = await _splashRepository.executeWithParams(params: params);

    if (value.isNullOrEmpty || value!.users is! List) {
      return null;
    }

    final column = params.columns;

    if (column.isNullOrEmpty) return null;

    return value.users?.first;
  }
}
