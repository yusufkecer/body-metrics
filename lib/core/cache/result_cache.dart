import 'dart:async';
import 'package:bmicalculator/core/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@injectable
final class ResultCache extends ImpCache<User> {
  ResultCache()
      : super(path: 'result.db', initDatabase: ResultCache().onCreate);

  FutureOr<void> onCreate(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_time INTEGER NOT NULL
        )
      ''');
  }
}
