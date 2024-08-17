import 'dart:async';

import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class BMICache extends ImpCache implements CacheMethods<BMI, BMIS> {
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
  Future<BMIS> select(Database? db, Map<String, dynamic> value) {
    // TODO: implement select
    throw UnimplementedError();
  }
}
