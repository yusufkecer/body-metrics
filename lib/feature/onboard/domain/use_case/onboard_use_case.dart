import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class OnboardUseCase implements UseCase<bool, AppModel> {
  const OnboardUseCase(this._onboardRepository);
  final Repository<int, AppModel> _onboardRepository;

  @override
  Future<bool?> executeWithParams({AppModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _onboardRepository.executeWithParams(params: params);
    return result?.convertBoolResult;
  }
}
