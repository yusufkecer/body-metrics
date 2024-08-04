import 'package:flutter/foundation.dart';

@immutable
abstract interface class BaseModel<T> {
  const BaseModel.fromJson();
  Map<String, dynamic> toJson();
}

@immutable
abstract interface class IdModel {
  int? get id;
}
