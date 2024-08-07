import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@Injectable(as: CacheMethods<User>)
final class UserCache extends ImpCache<User> implements CacheMethods<Users> {
  UserCache() : super(initTable: onCreate);

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          surname TEXT NULL,
          gender int NOT NULL 
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
  Future<Users> select(Database? db, Map<String, dynamic> value) async {
    //if (value.isNotEmpty) {}

    final result = await db?.query(table);
    result.log;
    if (result != null && result.isNotEmpty) {
      final usersList = result.map(User.fromJson).toList();
      return Users(users: usersList);
    }
    throw Exception('User not found');
  }

  @override
  Future<bool> delete(Database? db, int id) {
    throw UnimplementedError();
  }

  @override
  Future<Users> selectAll(Database? db) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAll(Database? db) {
    throw UnimplementedError();
  }
}
