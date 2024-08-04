import 'dart:async';

import 'package:bmicalculator/core/index.dart';
import 'package:sqflite/sqflite.dart';

base class ImpCache<T extends BaseModel<T>> implements BaseDatabase {
  ImpCache({required this.path, required this.initDatabase});

  Database? _db;
  Database? get db => _db;

  @override
  String? path;

  @override
  int get version => 1;

  final FutureOr<void> Function(Database db, int version)? initDatabase;

  @override
  Future<void> createDatabase() async {
    print("create db");
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: (db, version) {
        initDatabase!(db, version);
      },
    );
    'database created'.logInfo();
  }

  @override
  Future<void> closeDb() async {
    if (_db != null) {
      await _db?.close();
      _db = null;
      'database closed'.logInfo();
    }
  }

  @override
  Future<void> deleteDb() async {
    final path = await getDatabasesPath();
    await deleteDatabase('$path/${this.path}');
    'database deleted'.logInfo();
  }
}
