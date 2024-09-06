import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/bmi_cache/bmi_cache_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class BmiCache extends ImpCache implements CacheMethods<UserMetrics, Json> {
  BmiCache();

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          ${BmiCacheColumns.id.value} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${BmiCacheColumns.date.value} TEXT NOT NULL,
          ${BmiCacheColumns.weight.value} TEXT NULL,
          ${BmiCacheColumns.height.value} int NOT NULL, 
          ${BmiCacheColumns.userId.value} INTEGER NOT NULL,
          ${BmiCacheColumns.result.value} int NOT NULL,
          FOREIGN KEY (${BmiCacheColumns.userId.value}) REFERENCES user(id)
        )
      ''');
  }

  @override
  Future<bool> delete(Database? db, int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(Database? db, Json value) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  String get table => BmiCacheColumns.table.value;

  @override
  Future<bool> update(Database? db, Json value) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<UserMetrics?> select(Database? db, Json value) {
    throw UnimplementedError();
  }

  @override
  Future<UserMetrics?> selectAll(Database? db) {
    // TODO: implement selectAll
    throw UnimplementedError();
  }
}