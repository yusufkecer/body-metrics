import 'package:bodymetrics/data/cache/user_cache/user_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late UserCache userCache;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    userCache = UserCache();
    // We use in-memory database by overriding path in AppUtil or similar?
    // ImpCache uses AppUtil.databasePath.
    // sqflite_ffi uses in-memory if path is null or ':memory:'.
    // But ImpCache joins path with getDatabasesPath().
    // We can't easily change path in ImpCache without subclassing or mocking getDatabasesPath.
    // However, sqflite_common_ffi supports file databases too.
    // We just need to ensure isolation.
    // For now, let's see if we can just run it.
  });

  test('UserCache inserts and selects user successfully', () async {
    // Initialize DB (now should create table)
    final db = await userCache.initializeDatabase();

    // Check if table exists
    final tables = await db!.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', 'user'],
    );
    expect(tables.isNotEmpty, true, reason: 'Table should be created');

    // Insert user
    final userJson = {
      'name': 'Test',
      'surname': 'User',
      'gender': 'male', // User.fromJson expects String 'male'
      'height': 180,
      'birthOfDate': '1990-01-01',
      // id is autoincrement
    };

    // Note: insert method closes the database!
    final id = await userCache.insert(db, userJson);
    expect(id, isPositive);

    // Re-initialize DB for select
    final db2 = await userCache.initializeDatabase();

    // Select user
    final selectedUsers = await userCache.select(db2, {'id': id});
    expect(selectedUsers, isNotNull);
    expect(selectedUsers!.users, isNotEmpty);
    expect(selectedUsers.users!.first.name, 'Test');

    await userCache.closeDb();
  });
}
