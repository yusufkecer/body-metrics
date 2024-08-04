import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class BMICache extends ImpCache<BMI> {
  BMICache() : super(initDatabase: onCreate);

  static FutureOr<void> onCreate(Database db, int version) async {
    const table = 'result';
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
