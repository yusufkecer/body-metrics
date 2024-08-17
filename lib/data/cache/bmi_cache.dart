import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class BMICache extends ImpCache implements CacheMethods<UserMetric, UserMetric> {
  BMICache() : super(initTable: initializeTable);

  static FutureOr<void> initializeTable(Database db, int version) async {
    const table = 'result';
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          weight TEXT NULL,
          height int NOT NULL 
          user_id INTEGER NOT NULL,
          result int NOT NULL,
          FOREIGN KEY (user_id) REFERENCES user(id)
        )
      ''');
  }

  @override
  Future<bool> delete(Database? db, int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAll(Database? db) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(Database? db, Map<String, dynamic> value) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  // TODO: implement table
  String get table => 'result';

  @override
  Future<bool> update(Database? db, Map<String, dynamic> value) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<UserMetric?> select(Database? db, UserMetric value) {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<UserMetric?> selectAll(Database? db) {
    // TODO: implement selectAll
    throw UnimplementedError();
  }
}
