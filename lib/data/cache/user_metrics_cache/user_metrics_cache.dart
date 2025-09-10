import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
final class UserMetricsCache extends ImpCache implements CacheMethods<UserMetrics, Json, UserMetric, UserMetrics> {
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

    'init database'.log();
  }

  @override
  Future<int> delete(Database? db, int id) {
    throw UnimplementedError();
  }

  @override
  Future<int> insert(Database? db, UserMetric value) async {
    if (db == null) {
      'Database is null'.w();
      return 0;
    }

    final result1 = await db.query(table);
    'result $result1'.log();
    final result = await db.insert(table, value.toJson());
    'result $result'.log();
    await closeDb();

    if (result > 0) {
      'UserMetrics inserted'.log();
      return result;
    } else {
      'UserMetrics not inserted'.w();
      return 0;
    }
  }

  @override
  String get table => UserMetricsColumns.table.value;

  @override
  Future<int> update(Database? db, UserMetric value) async {
    if (db == null) {
      'Database is null'.e();
      return 0;
    }

    final jsonData = value.toJson();
    final filteredValue = jsonData.entries.where((entry) => entry.value != null).toList();

    if (filteredValue.isEmpty) {
      'No values to update'.e();
      return 0;
    }

    final columns = filteredValue.map((e) => '${e.key} = ?').join(', ');

    final values = filteredValue.map((e) => e.value).toList();

    final result = await db.rawUpdate(
      'UPDATE $table SET $columns WHERE id = ?',
      [...values, value.id],
    );

    await closeDb();

    return result;
  }

  @override
  Future<UserMetrics?> select(Database? db, Json value, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }

    final result = await db!.query(
      '$table WHERE ${UserMetricsColumns.userId.value} = ?',
      whereArgs: [value['userId']],
    );
    'UserMetric selected $result'.log();
    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics = UserMetrics(userMetrics: result.map(UserMetric.fromJson).toList());
      'UserMetrics selected $userMetrics'.log();
      return userMetrics;
    } else {
      'UserMetric not selected'.w();
      return null;
    }
  }

  @override
  Future<UserMetrics?> selectAll(Database? db, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }
    final result = await db!.query(table);
    'userMetrics result $result'.log();
    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics = UserMetrics(userMetrics: result.map(UserMetric.fromJson).toList());
      'UserMetrics selected $userMetrics'.log();
      return userMetrics;
    } else {
      'UserMetrics not selected'.w();
      return null;
    }
  }
}
