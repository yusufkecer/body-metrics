import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract interface class CacheMethods<T, U> {
  String get table;
  Future<bool> insert(Database? db, Map<String, dynamic> value);
  Future<T> selectFirst(Database? db, Map<String, dynamic> value);
  Future<U> selectAllFilter(Database? db, Map<String, dynamic> value);
  Future<bool> delete(Database? db, int id);
  Future<U> selectAll(Database? db);
  Future<bool> deleteAll(Database? db);
}
