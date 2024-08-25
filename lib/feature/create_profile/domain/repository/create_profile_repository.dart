part of '../../create_profile.dart';

@injectable
class CreateProfileRepository implements BaseUseCase<bool?, User> {
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
    'User Data: $userMap'.log;
    final result = _userCache.insert(db, userMap);

    return result;
  }
}
