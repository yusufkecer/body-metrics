import 'package:bodymetrics/core/index.dart';

import 'package:bodymetrics/feature/splash/domain/repository/splash_app_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@injectable
final class SplashAppUseCase implements BaseUseCase<AppModel, EmptyModel> {
  const SplashAppUseCase(this._splashRepository);
  final SplashAppRepository _splashRepository;

  @override
  Future<AppModel?> executeWithParams({EmptyModel? params}) {
    return _splashRepository.executeWithParams(params: params);
  }
}
