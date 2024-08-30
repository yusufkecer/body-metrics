import 'dart:async';
import 'dart:convert';

import 'package:bodymetrics/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class ImpCache implements BaseDatabase {
  ImpCache();

  Database? _db;
  Database? get db => _db;

  @override
  String? path = 'bodymetrics.db';

  @override
  int get version => 1;

  @override
  Future<Database?> initializeDatabase({Future<void> Function()? initTable}) async {
    final path = await getDatabasesPath();

    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
    );
    'opened'.log;
    return _db;
  }

  @override
  Future<void> closeDb() async {
    if (_db != null) {
      await _db?.close();
      _db = null;
      'database closed'.log;
    }
  }

  @override
  Future<void> deleteDb() async {
    final path = await getDatabasesPath();
    await deleteDatabase('$path/${this.path}');
    'database deleted'.log;
  }

  @override
  Future<void> deleteTable(String table) async {
    if (_db != null) {
      await _db?.execute('DROP TABLE IF EXISTS $table');
      'table deleted'.log;
    }
  }

  @override
  Future<bool> isExist() async {
    if (db == null) return false;

    final tableNames = ['app', 'user', 'result'];
    final rowList = await db!.query(
      'sqlite_master',
      columns: ['name'],
      where: 'type = ? AND name IN (?, ?, ?)',
      whereArgs: ['table', ...tableNames],
    );

    'rowList: $rowList'.log;

    jsonEncode(rowList).log;
    return rowList.length == tableNames.length;
  }
}
