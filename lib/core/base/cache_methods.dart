import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract interface class CacheMethods<T> {
  Future<bool> insert(Database? db, Map<String, dynamic> value);
  Future<T> select(int id);
  Future<bool> remove(int id);
  Future<List<T>> selectAll();
  Future<bool> delete();
}
