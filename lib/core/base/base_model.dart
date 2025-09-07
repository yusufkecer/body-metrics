import 'package:bodymetrics/core/index.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract interface class BaseModel<T> implements _IdModel {
  const BaseModel.fromJson();
  Json toJson();
}

@immutable
abstract interface class _IdModel {
  int? get id;
}
