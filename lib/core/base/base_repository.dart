import 'package:flutter/material.dart';

@immutable
abstract interface class BaseRepository<T, Params> {
  T execute(Params filter);
  T executeAll();
}
