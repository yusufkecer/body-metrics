import 'package:bmicalculator/core/index.dart';
import 'package:sqflite/sqflite.dart';

base class ImpCache implements BaseCache {
  @override
  String? path;

  @override
  int get version => 1;

  @override
  Future<Database> createDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: initDatabase,
    );
  }

  @override
  Future<void> initDatabase(Database db, int version) async {}

  ImpCache({
    required this.path,
  });
}
