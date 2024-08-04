import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class BMICache extends ImpCache<User> {
  BMICache() : super(path: 'result.db', initDatabase: BMICache().onCreate);

  final String table = 'user';

  FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          weight TEXT NULL,
          height int NOT NULL 
          user_id INTEGER NOT NULL,
          result int NOT NULL,
          FOREIGN KEY (user_id) REFERENCES user(id)
        )
      ''');
  }
}
