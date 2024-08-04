import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class UserCache extends ImpCache<User> {
  UserCache() : super(path: 'BMI.db', initDatabase: UserCache().onCreate);

  final String table = 'user';

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          surname TEXT NULL,
          gender int NOT NULL 
        )
      ''');

    'init database'.logInfo();
  }
}
