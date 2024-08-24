part of '../../create_profile.dart';

class CreateProfileRepository implements BaseUseCase<Future<bool?>, User> {
  CreateProfileRepository() {
    _userCache = Locator.sl<UserCache>();
  }

  late final UserCache _userCache;
  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<bool> executeWithParams(User user) async {
    final db = await _userCache.initializeDatabase();
    final userMap = user.toJson();
    return _userCache.insert(db, userMap);
  }
}
