import 'dart:async';

import 'package:bodymetrics/core/index.dart';
import 'package:sqflite/sqflite.dart';

base class ImpCache<T extends BaseModel<T>> implements BaseDatabase {
  ImpCache({required this.initTable});

  Database? _db;
  Database? get db => _db;

  @override
  String? path = 'bmi.db';

  @override
  int get version => 1;

  final FutureOr<void> Function(Database db, int version)? initTable;

  @override
  Future<Database?> initializeDatabase() async {
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
