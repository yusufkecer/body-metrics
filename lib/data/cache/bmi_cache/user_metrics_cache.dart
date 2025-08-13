import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/bmi_cache/user_metrics_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
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
          ${UserMetricsColumns.bmi.value} REAL NULL,
          FOREIGN KEY (${UserMetricsColumns.userId.value}) REFERENCES user(id)
        )
      ''');
  }

  @override
  Future<int> delete(Database? db, int id) async {
    if (db == null) {
      'Database is null'.w();
      return 0;
    }

    final result = await db.delete(
      table,
      where: '${UserMetricsColumns.id.value} = ?',
      whereArgs: [id],
    );

    await closeDb();

    if (result > 0) {
      'User metric deleted'.log();
    } else {
      'User metric not deleted'.w();
    }

    return result;
  }

  @override
  Future<int> insert(Database? db, UserMetricEntity value) async {
    if (db == null || value.data.isEmpty) {
      'Database or value is null/empty'.w();
      return 0;
    }

    // Add current date if not provided
    final data = Map<String, dynamic>.from(value.data);
    if (!data.containsKey(UserMetricsColumns.date.value)) {
      data[UserMetricsColumns.date.value] = DateTime.now().toIso8601String();
    }

    // Add user_id if not provided but available in AppUtil
    if (!data.containsKey(UserMetricsColumns.userId.value)) {
      data[UserMetricsColumns.userId.value] = AppUtil.currentUserId;
    }

    final result = await db.insert(table, data);

    await closeDb();

    if (result > 0) {
      'User metric inserted'.log();
      return result;
    } else {
      'User metric not inserted'.w();
      return 0;
    }
  }

  @override
  String get table => UserMetricsColumns.table.value;

  @override
  Future<int> update(Database? db, UserMetricEntity value) async {
    if (value.isNullOrEmpty || db.isNullOrEmpty) {
      'Value is empty'.e();
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

    await closeDb();

    return result;
  }

  @override
  Future<UserMetrics?> select(Database? db, Json value, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }

    final userId = value['user_id'];
    if (userId == null) {
      'User ID is null'.w();
      return null;
    }

    final result = await db!.query(
      table,
      where: '${UserMetricsColumns.userId.value} = ?',
      whereArgs: [userId],
      orderBy: '${UserMetricsColumns.date.value} ASC',
    );

    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics = result.map((row) => UserMetric(
        id: row[UserMetricsColumns.id.value] as int?,
        date: row[UserMetricsColumns.date.value] as String?,
        weight: double.tryParse(row[UserMetricsColumns.weight.value]?.toString() ?? ''),
        bmi: (row[UserMetricsColumns.bmi.value] as num?)?.toDouble() ?? 
             _calculateBmi(
               double.tryParse(row[UserMetricsColumns.weight.value]?.toString() ?? ''), 
               (row[UserMetricsColumns.height.value] as int?)?.toDouble()
             ),
      )).toList();
      
      return UserMetrics(userMetrics: userMetrics);
    }
    
    return null;
  }

  @override
  Future<UserMetrics?> selectAll(Database? db, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }

    final result = await db!.query(
      table,
      orderBy: '${UserMetricsColumns.date.value} ASC',
    );

    await closeDb();

    if (result.isNotEmpty) {
      final userMetrics = result.map((row) => UserMetric(
        id: row[UserMetricsColumns.id.value] as int?,
        date: row[UserMetricsColumns.date.value] as String?,
        weight: double.tryParse(row[UserMetricsColumns.weight.value]?.toString() ?? ''),
        bmi: (row[UserMetricsColumns.bmi.value] as num?)?.toDouble() ?? 
             _calculateBmi(
               double.tryParse(row[UserMetricsColumns.weight.value]?.toString() ?? ''), 
               (row[UserMetricsColumns.height.value] as int?)?.toDouble()
             ),
      )).toList();
      
      return UserMetrics(userMetrics: userMetrics);
    }
    
    return null;
  }

  double? _calculateBmi(double? weight, double? height) {
    if (weight == null || height == null || height == 0) return null;
    return weight / (height * height);
  }
}
