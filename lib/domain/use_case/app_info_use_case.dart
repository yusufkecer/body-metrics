import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
final class AppInfoUseCase implements UseCase<Pages, EmptyModel> {
  const AppInfoUseCase(this._repository);
  final AppInfoRepository _repository;

  @override
  Future<Pages> executeWithParams({EmptyModel? params}) async {
    if (params == null) throw ArgumentError.notNull();

    final result = await _repository.executeWithParams();
    if (result.isNullOrEmpty) {
      return Pages.avatarPage;
    }
    if (result == null) return Pages.onboardPage;
    return result;
  }
}
