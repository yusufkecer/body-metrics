import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SetIdUseCase implements BaseUseCase<bool, int> {
  const SetIdUseCase();

  @override
  Future<bool?> executeWithParams({int? params}) async {
    if (params == null) throw ArgumentError.notNull();

    AppUtil.currentUserId = params;

    return true;
  }
}
