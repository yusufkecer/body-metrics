import 'dart:async';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache_tables.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@injectable
final class UserCache extends ImpCache implements CacheMethods<Users, Json> {
  UserCache();

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user (
          ${UserCacheTables.id.value} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UserCacheTables.name.value} TEXT NOT NULL,
          ${UserCacheTables.surname.value} TEXT NULL,
          ${UserCacheTables.gender.value} INTEGER NULL,
          ${UserCacheTables.avatar.value} TEXT NULL,
          ${UserCacheTables.birthOfDate.value} TEXT NULL
        )
      ''');

    'init database'.log;
  }

  @override
  String get table => UserCacheTables.table.value;

  @override
  Future<bool> insert(Database? db, Json value) async {
    if (db == null) {
      'Database is null'.w;
      return false;
    }
    final result = await db.insert(table, value);
    await closeDb();
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
  Future<Users?> select(Database? db, Json user) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w;
      return null;
    }
    final result = await db!.query(table);

    if (result.isNotEmpty) {
      final users = Users(users: result.map(User.fromJson).toList());
      'User selected $users'.log;
      return users;
    } else {
      'User not selected'.w;
      return null;
    }
  }

  @override
  Future<Users?> selectAll(Database? db) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w;
      return null;
    }
    final result = await db!.query(table);

    if (result.isNotEmpty) {
      final users = Users(users: result.map(User.fromJson).toList());
      'User selected $users'.log;
      return users;
    } else {
      'User not selected'.w;
      return null;
    }
  }

  @override
  Future<bool> update(Database? db, Map<String, dynamic> value) {
    throw UnimplementedError();
  }
}
