import 'dart:async';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@injectable
final class UserCache extends ImpCache implements CacheMethods<User, Users> {
  UserCache() : super(initTable: onCreate);

  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          surname TEXT NULL,
          gender int NOT NULL,
          avatar TEXT NULL,
        )
      ''');

    'init database'.log;
  }

  @override
  String get table => 'user';

  @override
  Future<bool> insert(Database? db, Map<String, dynamic> value) async {
    if (db == null) {
      'Database is null'.w;
      return false;
    }
    final result = await db.insert(table, value);

    if (result > 0) {
      'User inserted'.log;
      return true;
    } else {
      'User not inserted'.w;
      return false;
    }
  }

  @override
  Future<bool> delete(Database? db, int id) {
    throw UnimplementedError();
  }

  @override
  Future<Users> select(Database? db, Map<String, dynamic> value) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAll(Database? db) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Database? db, Map<String, dynamic> value) {
    throw UnimplementedError();
  }
}
