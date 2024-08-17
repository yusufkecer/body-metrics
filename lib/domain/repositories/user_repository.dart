import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/user_cache.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
final class UserRepository implements BaseRepository<Users, User> {
  UserRepository() {
    _userCache = Locator.sl<UserCache>();
  }

  late final UserCache _userCache;

  @override
  Future<bool> save(Map<String, dynamic> filter) async {
    final db = await _userCache.initializeDatabase();

    return _userCache.insert(db, filter);
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _userCache.initializeDatabase();
    return _userCache.delete(db, id);
  }

  @override
  Future<bool> update(Map<String, dynamic> filter) async {
    final db = await _userCache.initializeDatabase();
    return _userCache.update(db, filter);
  }

  @override
  Future<Users?> get(User user) async {
    final db = await _userCache.initializeDatabase();
    final users = await _userCache.select(db, user);
    return users;
  }

  @override
  Future<bool> deleteAll() async {
    final db = await _userCache.initializeDatabase();
    return _userCache.deleteAll(db);
  }
}
