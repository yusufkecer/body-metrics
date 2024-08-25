import 'dart:async';

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
  Future<Database?> initializeDatabase({void Function()? initTable}) async {
    'database log'.log;
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: (db, version) => initTable?.call(),
    );
    'database created'.log;
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
}
