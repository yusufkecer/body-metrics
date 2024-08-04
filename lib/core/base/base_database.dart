abstract interface class BaseDatabase {
  String? path;

  final int version = 1;

  Future<void> createDatabase();
  //close
  Future<void> close();
}
