import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/feature/index.dart';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

part 'app_cache_tables.dart';

@injectable
final class AppCache extends ImpCache implements CacheMethods<JsonList, AppModel> {
  AppCache() : super();

  @override
  String get table => _Table.table.value;

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      ${_Table.theme.value} TEXT NULL,
      ${_Table.language.value} TEXT NOT NULL,
      ${_Table.isCompletedOnboard.value} INTEGER NULL,
      ${_Table.activeUser.value} INTEGER NULL,
      ${_Table.page} TEXT NULL
    )
  ''');
  }

  final List<String> _columns = [
    _Table.theme.value,
    _Table.language.value,
    _Table.isCompletedOnboard.value,
    _Table.activeUser.value,
    _Table.page.value,
  ];

  ///There should be only one row
  ///will only work [Onboard]
  ///another business logic should use [update] method
  @override
  Future<bool> insert(Database? db, AppModel value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return false;
    }

    final json = value.toJson();

    final result = await db!.insert(table, json);

    'value inserted $result'.log;

    await closeDb();

    return result.boolResult;
  }

  @override
  Future<JsonList> select(Database? db, AppModel value) {
    throw UnimplementedError();
  }

  @override
  Future<JsonList> selectAll(Database? db) async {
    final value = await db!.query(table);
    return value;
  }

  @override
  Future<bool> update(Database? db, AppModel value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return false;
    }

    JsonMap? json;

    for (final element in _columns) {
      if (value.toJson().containsKey(element)) {
        json?[element] = value.toJson()[element];
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
