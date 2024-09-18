import 'package:flutter/material.dart';

@immutable
abstract interface class BaseUseCase<T, Params> {
  Future<T?>? executeWithParams(Params params);
  Future<T?>? execute();
}
