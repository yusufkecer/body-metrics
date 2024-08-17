import 'package:flutter/material.dart';

@immutable
abstract interface class BaseRepository<T> {
  Future<bool> save(Map<String, dynamic> filter);
  Future<bool> update(Map<String, dynamic> filter);

  Future<T> get(Map<String, dynamic> filter);

  Future<bool> delete(int id);
  Future<bool> deleteAll();
}
