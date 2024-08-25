part of '../../splash.dart';

@immutable
@injectable
final class SplashRepository implements BaseUseCase<AppModel?, Object> {
  final AppCache _appCache = Locator.sl<AppCache>();

  @override
  Future<AppModel> execute() async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    final appModel = AppModel.fromJson(values.first);
    return appModel;
  }

  @override
  Future<AppModel>? executeWithParams(_) => null;
}
