import 'package:flutter/material.dart';

@immutable
abstract interface class BaseRepository<T, U> {
  Future<bool> save(Map<String, dynamic> filter);
  Future<bool> update(Map<String, dynamic> filter);

  Future<T?> get(U filter);

  Future<bool> delete(int id);
  Future<bool> deleteAll();
}
