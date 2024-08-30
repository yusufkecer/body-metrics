import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/feature/index.dart';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

part 'app_cache_tables.dart';

@injectable
final class AppCache extends ImpCache implements CacheMethods<JsonList, Json> {
  AppCache() : super();

  @override
  String get table => AppTable.table.value;

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      ${AppTable.theme.value} TEXT NULL,
      ${AppTable.language.value} TEXT NULL,
      ${AppTable.isCompletedOnboard.value} INTEGER NULL,
      ${AppTable.activeUser.value} INTEGER NULL,
      ${AppTable.page.value} TEXT NULL
    )
  ''');
  }

  final List<String> _columns = [
    AppTable.theme.value,
    AppTable.language.value,
    AppTable.isCompletedOnboard.value,
    AppTable.activeUser.value,
    AppTable.page.value,
  ];

  ///There should be only one row
  ///will only work [Onboard]
  ///another business logic should use [update] method
  @override
  Future<bool> insert(Database? db, Json value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return false;
    }

    final result = await db!.insert(table, value);

    'value inserted $result'.log;

    await closeDb();

    return result.boolResult;
  }

  @override
  Future<JsonList> select(Database? db, Json value) {
    throw UnimplementedError();
  }

  @override
  Future<JsonList> selectAll(Database? db) async {
    final value = await db!.query(table);
    return value;
  }

  @override
  Future<bool> update(Database? db, Json value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return false;
    }

    Json? json;

    for (final element in _columns) {
      if (value.containsKey(element)) {
        json?[element] = value[element];
      }
    }
    if (json.isNullOrEmpty) return false;

    final result = await db!.update(table, json!);

    'value updated $result'.log;

    await closeDb();

    return result.boolResult;
  }

  @override
  Future<bool> delete(Database? db, int id) {
    throw UnimplementedError();
  }
}
