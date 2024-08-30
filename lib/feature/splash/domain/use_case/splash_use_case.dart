part of '../../presentation/splash.dart';

@immutable
@injectable
final class SplashUseCase implements BaseUseCase<AppModel?, Object> {
  final SplashRepository _splashRepository = Locator.sl<SplashRepository>();

  @override
  Future<AppModel?> execute() {
    return _splashRepository.execute();
  }

  @override
  Future<AppModel>? executeWithParams(_) => null;
}
