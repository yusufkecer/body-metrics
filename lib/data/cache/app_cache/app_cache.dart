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
    implements BaseCache<Json, Json, Json, Json> {
  AppCache() : super();

  @override
  String get table => AppCacheColumns.table.value;

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $table (
      ${AppCacheColumns.isCompletedOnboard.value} INTEGER NULL,
      ${AppCacheColumns.activeUser.value} INTEGER NULL,
      ${AppCacheColumns.page.value} TEXT NULL,
      ${AppCacheColumns.jwtToken.value} TEXT NULL,
      ${AppCacheColumns.email.value} TEXT NULL,
      ${AppCacheColumns.syncPending.value} INTEGER DEFAULT 0
    )
  ''');

    final cols = await db.rawQuery('PRAGMA table_info($table)');
    final colNames = cols.map((c) => c['name']! as String).toSet();
    if (!colNames.contains(AppCacheColumns.syncPending.value)) {
      await db.execute(
        'ALTER TABLE $table ADD COLUMN ${AppCacheColumns.syncPending.value} INTEGER DEFAULT 0',
      );
    }

    final count =
        Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $table'),
        ) ??
        0;
    if (count == 0) {
      await db.insert(table, {AppCacheColumns.syncPending.value: 0});
    }
  }

  final List<String> _columns = [
    AppCacheColumns.isCompletedOnboard.value,
    AppCacheColumns.activeUser.value,
    AppCacheColumns.page.value,
    AppCacheColumns.jwtToken.value,
    AppCacheColumns.email.value,
    AppCacheColumns.syncPending.value,
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

    final existing =
        Sqflite.firstIntValue(
          await db!.rawQuery('SELECT COUNT(*) FROM $table'),
        ) ??
        0;
    if (existing > 0) return update(db, value);

    final result = await db.insert(table, value);

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
    throw UnimplementedError();
  }

  @override
  Future<Json> selectAll(
    Database? db, {
    List<String>? columns,
    List<JoinEntity>? joins,
  }) async {
    if (db.isNullOrEmpty) {
      'Database is empty'.e();
      return {};
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

    final value = await db!.rawQuery(
      "SELECT ${columns.join(', ')} FROM $table $join",
    );

    await closeDb();
    if (value.isNullOrEmpty) return {};

    return value.first;
  }

  @override
  Future<int> update(Database? db, Json value) async {
    if (value.isEmpty || db == null) {
      'Value is empty'.e();
      return 0;
    }
    'app_cache: update called'.log();
    final filteredValue = value.entries
        .where((entry) => entry.value != null)
        .toList();

    if (filteredValue.isEmpty) {
      'No values to update'.e();
      return 0;
    }

    final columns = filteredValue.map((e) => '${e.key} = ?').join(', ');

    final values = filteredValue.map((e) => e.value).toList();

    final result = await db.rawUpdate('UPDATE $table SET $columns', values);

    await closeDb();

    return result;
  }

  @override
  Future<int> delete(Database? db, int id) {
    throw UnimplementedError();
  }
}
