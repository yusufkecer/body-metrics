import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
final class UserMetricsCache extends ImpCache
    implements BaseCache<UserMetrics, Json, UserMetric, UserMetrics> {
  UserMetricsCache();

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
          ${UserMetricsColumns.id.value} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UserMetricsColumns.date.value} TEXT NOT NULL,
          ${UserMetricsColumns.weight.value} REAL NULL,
          ${UserMetricsColumns.height.value} INTEGER NOT NULL,
          ${UserMetricsColumns.userId.value} INTEGER NOT NULL,
          ${UserMetricsColumns.bmi.value} REAL NOT NULL,
          ${UserMetricsColumns.diff.value} REAL NULL,
          body_metric TEXT NULL,
          ${UserMetricsColumns.createdAt.value} TEXT NULL,
          FOREIGN KEY (${UserMetricsColumns.userId.value}) REFERENCES user(id)
        )
      ''');

    'init database'.log();
  }

  @override
  Future<int> delete(Database? db, int id) {
    throw UnimplementedError();
  }

  Future<int> deleteAllByUserId(Database? db, int userId) async {
    if (db == null) {
      'Database is null'.e();
      return 0;
    }
    final count = await db.delete(
      table,
      where: '${UserMetricsColumns.userId.value} = ?',
      whereArgs: [userId],
    );
    'UserMetricsCache: deleted $count rows for userId=$userId'.log();
    return count;
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

    if (value.id == null) {
      'UserMetric id is null'.e();
      return 0;
    }

    final jsonData = value.toJson();
    final filteredValue = jsonData.entries
        .where((entry) => entry.value != null && entry.key != 'id')
        .toList();

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
  Future<UserMetrics?> select(
    Database? db,
    Json value, {
    List<String>? columns,
    List<JoinEntity>? joins,
  }) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }

    final result = await db!.query(
      table,
      where: '${UserMetricsColumns.userId.value} = ?',
      whereArgs: [value[UserMetricsColumns.userId.value]],
      orderBy: '${UserMetricsColumns.createdAt.value} ASC, ${UserMetricsColumns.id.value} ASC',
    );
    'UserMetric selected $result'.log();
    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics =
          UserMetrics(userMetrics: result.map(UserMetric.fromJson).toList());
      'UserMetrics selected $userMetrics'.log();
      return userMetrics;
    } else {
      'UserMetric not selected'.w();
      return null;
    }
  }

  @override
  Future<UserMetrics?> selectAll(
    Database? db, {
    List<String>? columns,
    List<JoinEntity>? joins,
  }) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }
    final result = await db!.query(
      table,
      orderBy: '${UserMetricsColumns.createdAt.value} ASC, ${UserMetricsColumns.id.value} ASC',
    );
    'userMetrics result $result'.log();
    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics =
          UserMetrics(userMetrics: result.map(UserMetric.fromJson).toList());
      'UserMetrics selected $userMetrics'.log();
      return userMetrics;
    } else {
      'UserMetrics not selected'.w();
      return null;
    }
  }
}
