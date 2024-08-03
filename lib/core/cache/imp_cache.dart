import 'dart:async';

import 'package:bmicalculator/core/index.dart';
import 'package:sqflite/sqflite.dart';

base class ImpCache<T extends BaseModel<T>> implements BaseDatabase {
  ImpCache({required this.path, required this.initDatabase});

  @override
  String? path;

  @override
  int get version => 1;

  final FutureOr<void> Function(Database db, int version)? initDatabase;

  @override
  Future<Database> createDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: initDatabase,
    );
  }
}
