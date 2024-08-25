import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class AppCache extends ImpCache implements CacheMethods<JsonList, Settings> {
  AppCache() : super();

  @override
  String get table => 'settings';

  static FutureOr<void> initializeTable(Database db, int version) async {
    const table = 'settings';
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          theme TEXT NOT NULL,
          language TEXT NOT NULL,
          is_completed_onboarding INTEGER NOT NULL
        )
      ''');
  }

  final List<String> tables = ['theme', 'language', 'is_completed_onboarding'];

  @override
  Future<bool> insert(Database? db, Map<String, dynamic> value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return false;
    }

    var result = 0;

    for (final key in tables) {
      if (value.containsKey(key)) {
        result = await db!.insert(table, {key: value[key]});
        '$key inserted, success -> ${result.boolResult}'.log;
      }
    }
    await closeDb();
    return result.boolResult;
  }

  @override
  Future<JsonList> select(Database? db, Settings value) {
    throw UnimplementedError();
  }

  @override
  Future<JsonList> selectAll(Database? db) async {
    final value = await db!.query(table);
    return value;
  }

  @override
  Future<bool> update(Database? db, Map<String, dynamic> value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(Database? db, int id) {
    throw UnimplementedError();
  }
}
