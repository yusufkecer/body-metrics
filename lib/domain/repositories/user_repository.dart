import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@Injectable(as: BaseRepository)
final class UserRepository implements BaseRepository<Users> {
  final UserCache _userCache;
  final Database _db;
  UserRepository({required UserCache userCache, required Database db})
      : _userCache = userCache,
        _db = db;

  @override
  Future<bool> save(Map<String, dynamic> filter) async {
    return _userCache.insert(_db, filter);
  }

  @override
  Future<bool> delete(int id) async {
    return _userCache.delete(_db, id);
  }

  @override
  Future<bool> update(Map<String, dynamic> filter) async {
    return _userCache.update(_db, filter);
  }

  @override
  Future<Users> get(Map<String, dynamic> filter) async {
    return _userCache.select(_db, filter);
  }

  @override
  Future<bool> deleteAll() async {
    return _userCache.deleteAll(_db);
  }
}
