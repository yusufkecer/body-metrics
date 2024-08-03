import 'package:bmicalculator/core/index.dart';
import 'package:sqflite/sqflite.dart';

base class ImpCache<T extends BaseModel<T>> implements BaseCache {
  @override
  String? path;

  @override
  String? columnAge;

  @override
  String? columnId;

  @override
  String? columnName;

  @override
  String? table;

  @override
  int get version => 1;

  @override
  Future<void> createDatabase() async {}

  @override
  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      '$path/${this.path}',
      version: version,
      onCreate: (db, version) async {},
    );
  }

  ImpCache({
    required this.path,
    required this.table,
    required this.columnId,
    required this.columnName,
    required this.columnAge,
  });
}
