import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class OnboardUseCase implements BaseUseCase<bool, bool, AppModel> {
  const OnboardUseCase(this._onboardRepository);
  final OnboardRepository _onboardRepository;
  @override
  Future<bool>? execute() {
    return null;
  }

  @override
  Future<bool?> executeWithParams(AppModel params) async {
    final result = await _onboardRepository.executeWithParams(params);
    return result.convertBoolResult;
  }
}
