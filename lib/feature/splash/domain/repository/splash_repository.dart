part of '../../presentation/splash.dart';

@immutable
@injectable
final class SplashRepository implements BaseUseCase<AppModel, Users, ParamsEntity> {
  final AppCache _appCache = Locator.sl<AppCache>();
  final UserCache _userCache = Locator.sl<UserCache>();
  @override
  Future<AppModel?> execute() async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    if (values.isEmpty) {
      return null;
    }
    final appModel = AppModel.fromJson(values.first);
    return appModel;
  }

  @override
  Future<Users?> executeWithParams(ParamsEntity params) async {
    final columns = params.columns;
    final filters = params.filters ?? {};
    final db = await _userCache.initializeDatabase();

    return _userCache.select(db, filters, columns);
  }
}
