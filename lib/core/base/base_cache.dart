import 'package:sqflite/sqflite.dart';

abstract interface class BaseCache<T> {
  final String databaseName = 'bmi_calculator.db';

  String? table;
  String? columnId;
  String? columnName;
  String? columnAge;

  final int version = 1;
  Future<void> init();

  T read(String key);
  bool write(String key, T value);

  Future<Database> initDatabase();
  Future<void> createDatabase();
}
