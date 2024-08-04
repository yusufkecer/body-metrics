import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@injectable
final class UserCache extends ImpCache<User> implements CacheMethods<User> {
  UserCache() : super(initDatabase: onCreate);

  static FutureOr<void> onCreate(Database db, int version) async {
    const table = 'user';
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          surname TEXT NULL,
          gender int NOT NULL 
        )
      ''');

    'init database'.log;
  }

  @override
  Future<bool> insert(Database? db, Map<String, dynamic> value) async {
    if (db == null) {
      'Database is null'.w;
      return false;
    }
    final result = await db.insert('user', value);

    return result > 0;
  }

  @override
  Future<bool> delete() {
    throw UnimplementedError();
  }

  @override
  Future<User> select(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<User>> selectAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(int id) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
