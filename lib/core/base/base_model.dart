import 'package:flutter/material.dart';

@immutable
abstract interface class BaseModel<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
