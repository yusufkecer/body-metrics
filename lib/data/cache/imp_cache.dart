import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

typedef InitTableFunction = void Function(Database db, int version);

@injectable
class ImpCache implements BaseDatabase {
  ImpCache({required this.initTable});

  Database? _db;
  Database? get db => _db;

  @override
  String? path = 'bodymetrics.db';

  @override
  int get version => 1;

  InitTableFunction? initTable;

  @override
  Future<Database?> initializeDatabase() async {
    'database log'.log;
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: initTable,
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
}
