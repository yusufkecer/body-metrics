abstract interface class BaseDatabase {
  String? path;

  final int version = 1;

  Future<void> initializeDatabase();
  Future<void> closeDb();
  Future<void> deleteDb();
}