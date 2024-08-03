import 'package:sqflite/sqflite.dart';

abstract interface class BaseCache {
  String? path;

  final int version = 1;

  Future<void> initDatabase(Database db, int version);
  Future<Database> createDatabase();
}
