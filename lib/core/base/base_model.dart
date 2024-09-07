import 'package:flutter/foundation.dart';

@immutable
abstract interface class BaseModel<T> implements _IdModel {
  const BaseModel.fromJson();
  Map<String, dynamic> toJson();
}

@immutable
abstract interface class _IdModel {
  int? get id;
}
