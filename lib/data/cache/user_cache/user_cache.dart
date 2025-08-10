import 'dart:async';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@injectable
final class UserCache extends ImpCache implements CacheMethods<Users, Json, Json> {
  UserCache();

  @override
  Future<void> initializeTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user (
          ${UserCacheColumns.id.value} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${UserCacheColumns.name.value} TEXT NULL,
          ${UserCacheColumns.surname.value} TEXT NULL,
          ${UserCacheColumns.gender.value} INTEGER NULL,
          ${UserCacheColumns.avatar.value} TEXT NULL,
          ${UserCacheColumns.height.value} FLOAT NULL,
          ${UserCacheColumns.birthOfDate.value} TEXT NULL
        )
      ''');

    'init database'.log();
  }

  @override
  String get table => UserCacheColumns.table.value;

  @override
  Future<int> insert(Database? db, Json value) async {
    if (db == null) {
      'Database is null'.w();
      return 0;
    }
    final result = await db.insert(table, value);

    await closeDb();

    if (result > 0) {
      'User inserted'.log();
      return 1;
    } else {
      'User not inserted'.w();
      return 0;
    }
  }

  @override
  Future<int> delete(Database? db, int id) {
    throw UnimplementedError();
  }

  @override
  Future<Users?> select(Database? db, Json user, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }
    final result = await db!.query(
      '$table WHERE id = ?',
      whereArgs: [user['id']],
    );

    await closeDb();

    if (result.isNotEmpty) {
      final users = Users(users: result.map(User.fromJson).toList());
      'User selected $users'.log();
      return users;
    } else {
      'User not selected'.w();
      return null;
    }
  }

  @override
  Future<Users?> selectAll(Database? db, {List<String>? columns, List<JoinEntity>? joins}) async {
    if (db.isNullOrEmpty) {
      'Database is null'.w();
      return null;
    }
    final result = await db!.query(table);

    await closeDb();

    if (result.isNotEmpty) {
      final users = Users(users: result.map(User.fromJson).toList());
      'User selected $users'.log();
      return users;
    } else {
      'User not selected'.w();
      return null;
    }
  }

  @override
  Future<int> update(Database? db, Json value) async {
    if (value.isEmpty || db == null) {
      'Value is empty'.e();
      return 0;
    }

    final filteredValue = value.entries.where((entry) => entry.value != null).toList();

    if (filteredValue.isEmpty) {
      'No values to update'.e();
      return 0;
    }

    final columns = filteredValue.map((e) => '${e.key} = ?').join(', ');

    final values = filteredValue.map((e) => e.value).toList();

    final result = await db.rawUpdate(
      'UPDATE $table SET $columns',
      values,
    );

    await closeDb();

    return result;
  }
}
