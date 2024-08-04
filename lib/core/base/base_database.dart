abstract interface class BaseDatabase {
  String? path;

  final int version = 1;

  Future<void> createDatabase();
  Future<void> closeDb();
  Future<void> deleteDb();
}
