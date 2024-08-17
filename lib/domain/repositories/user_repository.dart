import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
final class UserRepository implements BaseRepository<Users> {
  UserRepository();

  late final UserCache? _userCache;

  @override
  Future<bool> save(Map<String, dynamic> filter) async {
    _userCache = Locator.sl<UserCache>();
    final db = await _userCache!.initializeDatabase();
    return _userCache!.insert(db, filter);
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _userCache!.initializeDatabase();
    return _userCache!.delete(db, id);
  }

  @override
  Future<bool> update(Map<String, dynamic> filter) async {
    final db = await _userCache!.initializeDatabase();
    return _userCache!.update(db, filter);
  }

  @override
  Future<Users> get(Map<String, dynamic> filter) async {
    final db = await _userCache!.initializeDatabase();
    return _userCache!.select(db, filter);
  }

  @override
  Future<bool> deleteAll() async {
    final db = await _userCache!.initializeDatabase();
    return _userCache!.deleteAll(db);
  }
}
