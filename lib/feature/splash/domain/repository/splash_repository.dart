part of '../../splash.dart';

@immutable
@injectable
final class SplashRepository implements BaseUseCase<Settings?, Object> {
  final AppCache _appCache = Locator.sl<AppCache>();

  @override
  Future<Settings> execute() async {
    final db = await _appCache.initializeDatabase();
    final values = await _appCache.selectAll(db);
    final settings = Settings.fromJson(values.first);
    return settings;
  }

  @override
  Future<Settings>? executeWithParams(_) => null;
}
