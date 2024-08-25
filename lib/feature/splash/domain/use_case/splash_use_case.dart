part of '../../splash.dart';

@immutable
@injectable
final class SplashUseCase implements BaseUseCase<Settings?, Object> {
  final SplashRepository _splashRepository = Locator.sl<SplashRepository>();

  @override
  Future<Settings> execute() {
    return _splashRepository.execute();
  }

  @override
  Future<Settings>? executeWithParams(_) => null;
}
