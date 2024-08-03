import 'package:sqflite/sqflite.dart';

abstract interface class BaseCache {
  String? path;

  String? table;
  String? columnId;
  String? columnName;
  String? columnAge;

  final int version = 1;

  Future<Database> initDatabase();
  Future<void> createDatabase();
}
