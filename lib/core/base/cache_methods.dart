import 'dart:async';
import 'package:sqflite/sqflite.dart';

abstract interface class CacheMethods<T, U> {
  String get table;
  Future<bool> insert(Database? db, Map<String, dynamic> value);
  Future<bool> update(Database? db, Map<String, dynamic> value);

  Future<T?> select(Database? db, U value);
  Future<T?> selectAll(Database? db);

  Future<bool> delete(Database? db, int id);
}
