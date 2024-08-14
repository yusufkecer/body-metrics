import 'dart:async';

import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@Injectable(as: CacheMethods<Settings>)
final class AppCache extends ImpCache<Settings> implements CacheMethods<Settings> {
  AppCache() : super(initTable: initializeTable);

  static FutureOr<void> initializeTable(Database db, int version) async {
    const table = 'settings';
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          theme TEXT NOT NULL,
          language TEXT NOT NULL
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
  Future<Settings> select(Database? db, Map<String, dynamic> value) {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<Settings> selectAll(Database? db) {
    // TODO: implement selectAll
    throw UnimplementedError();
  }

  @override
  // TODO: implement table
  String get table => throw UnimplementedError();
}
