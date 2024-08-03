import 'package:sqflite/sqflite.dart';

abstract interface class BaseDatabase {
  String? path;

  final int version = 1;

  Future<Database> createDatabase();
}
