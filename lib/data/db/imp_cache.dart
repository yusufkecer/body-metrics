import 'dart:async';
import 'dart:convert';

import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
base class ImpCache implements BaseDatabase {
  Database? _db;
  Database? get db => _db;

  final tables = [
    UserCacheColumns.table.value,
    UserMetricsColumns.table.value,
    AppCacheColumns.table.value,
  ];

  @override
  String? path = AppUtil.databasePath;

  @override
  int get version => AppUtil.databaseVersion;

  @override
  Future<Database?> initializeDatabase({Future<void> Function()? initTable}) async {
    final path = await getDatabasesPath();

    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
    );
    'opened'.log();
    return _db;
  }

  @override
  Future<void> closeDb() async {
    if (_db.isNotNull) {
      await _db?.close();
      _db = null;
      'database closed'.log();
    }
  }

  @override
  Future<void> deleteDb() async {
    final path = await getDatabasesPath();
    await deleteDatabase('$path/${this.path}');
    'database deleted'.log();
  }

  @override
  Future<void> deleteTable(String table) async {
    if (_db.isNotNull) {
      await _db?.execute('DROP TABLE IF EXISTS $table');
      'table deleted'.log();
    }
  }

  @override
  Future<bool> isExist() async {
    if (db == null) return false;

    final rowList = await db!.query(
      'sqlite_master',
      columns: ['name'],
      where: 'type = ? AND name IN (?, ?, ?)',
      whereArgs: ['table', ...tables],
    );

    'columns ${jsonEncode(rowList)}'.log();
    return rowList.isNotEmpty;
  }
}
