import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/bmi_cache/user_metrics_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class UserMetricsCache extends ImpCache implements CacheMethods<UserMetrics, Json, UserMetricEntity> {
  UserMetricsCache();

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          ${UserMetricsColumns.id.value} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UserMetricsColumns.date.value} TEXT NOT NULL,
          ${UserMetricsColumns.weight.value} TEXT NULL,
          ${UserMetricsColumns.height.value} int NOT NULL, 
          ${UserMetricsColumns.userId.value} INTEGER NOT NULL,
          ${UserMetricsColumns.result.value} int NOT NULL,
          FOREIGN KEY (${UserMetricsColumns.userId.value}) REFERENCES user(id)
        )
      ''');
  }

  @override
  Future<int> delete(Database? db, int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> insert(Database? db, UserMetricEntity value) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  String get table => UserMetricsColumns.table.value;

  @override
  Future<int> update(Database? db, UserMetricEntity value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e;
      return 0;
    }

    final filters = value.filters;

    final where = filters?.keys.map((key) => '$key = ?').join(' AND ');

    final whereArgs = filters?.values.toList() ?? [];

    final column = value.data.keys.map((key) => '$key = ?').join(', ');

    final columnArgs = value.data.values.toList();

    final result = await db!.rawUpdate(
      'UPDATE $table SET $column WHERE $where',
      [...columnArgs, ...whereArgs],
    );

    print('value updated $result');

    await closeDb();

    return result;
  }

  @override
  Future<UserMetrics?> select(Database? db, Json value, {List<String>? columns, List<JoinEntity>? joins}) {
    throw UnimplementedError();
  }

  @override
  Future<UserMetrics?> selectAll(Database? db, {List<String>? columns, List<JoinEntity>? joins}) {
    throw UnimplementedError();
  }
}
