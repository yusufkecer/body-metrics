import 'dart:async';
import 'package:bodymetrics/domain/index.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class CacheMethods<T, U> {
  String get table;
  Future<int> insert(Database? db, U value);
  Future<int> update(Database? db, U value);

  Future<T?> select(Database? db, U value, {List<String>? columns, List<JoinEntity>? joins});
  Future<T?> selectAll(Database? db, {List<String>? columns, List<JoinEntity>? joins});

  Future<int> delete(Database? db, int id);

  Future<void> initializeTable(Database db, int version);
}
