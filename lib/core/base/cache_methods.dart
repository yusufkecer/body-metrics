import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract interface class CacheMethods<T> {
  String get table;
  Future<bool> insert(Database? db, Map<String, dynamic> value);
  Future<T> select(Database? db, Map<String, dynamic> value);
  Future<bool> delete(Database? db, int id);
  Future<T> selectAll(Database? db);
  Future<bool> deleteAll(Database? db);
}
