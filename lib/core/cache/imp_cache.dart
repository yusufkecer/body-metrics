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
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: (db, version) {
        initDatabase!(db,version);
      },
    );
  }

  @override
  Future<void> close() async {
    if (path != null) {
      await _db?.close();
    }
  }
}
