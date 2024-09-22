import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
@immutable
class SaveAvatarRepository implements BaseUseCase<bool, bool, Json> {
  @override
  Future<bool?> execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool?> executeWithParams(Json params) {
    throw UnimplementedError();
  }
}
