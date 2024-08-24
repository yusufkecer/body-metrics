
// @injectable
// final class GetUserRepository implements BaseRepository<Future<bool?>, User> {
//   GetUserRepository() {
//     _userCache = Locator.sl<UserCache>();
//   }

//   late final UserCache _userCache;

//   // @override
//   // Future<Users> execute(UserFilters filter) async {
//   //   final db = await _userCache.initializeDatabase();

//   //   return _userCache.insert(db, filter);
//   // }
//   @override
//   Future<bool?> execute(User user) async {
//     final db = await _userCache.initializeDatabase();
//     final userMap = user.toJson();
//     return _userCache.insert(db, userMap);
//   }


//   // @override
//   // Future<bool> delete(int id) async {
//   //   final db = await _userCache.initializeDatabase();
//   //   return _userCache.delete(db, id);
//   // }

//   // @override
//   // Future<bool> update(Map<String, dynamic> filter) async {
//   //   final db = await _userCache.initializeDatabase();
//   //   return _userCache.update(db, filter);
//   // }

//   // @override
//   // Future<Users?> get(User user) async {
//   //   final db = await _userCache.initializeDatabase();
//   //   final users = await _userCache.select(db, user);
//   //   return users;
//   // }

//   // @override
//   // Future<bool> deleteAll() async {
//   //   final db = await _userCache.initializeDatabase();
//   //   return _userCache.deleteAll(db);
//   // }
// }
