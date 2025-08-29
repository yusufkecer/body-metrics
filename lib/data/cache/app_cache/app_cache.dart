import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/index.dart';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

part 'app_cache_columns.dart';

@lazySingleton
final class AppCache extends ImpCache
    implements CacheMethods<JsonList, Json, Json, Json> {
  AppCache() : super();

  @override
  String get table => AppCacheColumns.table.value;

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      ${AppCacheColumns.theme.value} TEXT NULL,
      ${AppCacheColumns.language.value} TEXT NULL,
      ${AppCacheColumns.isCompletedOnboard.value} INTEGER NULL,
      ${AppCacheColumns.activeUser.value} INTEGER NULL,
      ${AppCacheColumns.page.value} TEXT NULL
    )
  ''');
  }

  final List<String> _columns = [
    AppCacheColumns.theme.value,
    AppCacheColumns.language.value,
    AppCacheColumns.isCompletedOnboard.value,
    AppCacheColumns.activeUser.value,
    AppCacheColumns.page.value,
  ];

  ///There should be only one row
  ///will only work [Onboard]
  ///another business logic should use [update] method
  @override
  Future<int> insert(Database? db, Json value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e();
      return 0;
    }

    final result = await db!.insert(table, value);

    'value inserted'.log();

    await closeDb();

    return result;
  }

  @override
  Future<Json> select(
    Database? db,
    Json value, {
    List<String>? columns,
    List<JoinEntity>? joins,
  }) {
    //get first row
    return selectAll(db, columns: columns, joins: joins).then((value) {
      return value.first;
    });
  }

  @override
  Future<JsonList> selectAll(
    Database? db, {
    List<String>? columns,
    List<JoinEntity>? joins,
  }) async {
    if (db.isNullOrEmpty) {
      'Database is empty'.e();
      return [];
    }

    final join = StringBuffer();

    if (joins != null) {
      for (final item in joins) {
        join.write(
          'INNER JOIN ${item.table} ON ${item.joinKey} = ${item.currentKey}',
        );
      }
    }

    columns ??= _columns;

    final value =
        await db!.rawQuery("SELECT ${columns.join(', ')} FROM $table $join");

    await closeDb();

    return value;
  }

  @override
  Future<int> update(Database? db, Json value) async {
    if (value.isEmpty || db == null) {
      'Value is empty'.e();
      return 0;
    }
    'value: $value'.log();
    final filteredValue =
        value.entries.where((entry) => entry.value != null).toList();

    if (filteredValue.isEmpty) {
      'No values to update'.e();
      return 0;
    }

    final columns = filteredValue.map((e) => '${e.key} = ?').join(', ');

    'columns: $columns'.log();

    final values = filteredValue.map((e) => e.value).toList();

    final result = await db.rawUpdate(
      'UPDATE $table SET $columns',
      values,
    );

    await closeDb();

    return result;
  }

  @override
  Future<int> delete(Database? db, int id) {
    throw UnimplementedError();
  }
}
