part of '../../presentation/splash.dart';

@immutable
@injectable
final class SplashUseCase implements BaseUseCase<AppModel, String, ParamsEntity> {
  final SplashRepository _splashRepository = Locator.sl<SplashRepository>();

  @override
  Future<AppModel?> execute() {
    return _splashRepository.execute();
  }

  @override
  Future<String?> executeWithParams(ParamsEntity params) async {
    final value = await _splashRepository.executeWithParams(params);

    if (value.isNullOrEmpty || value!.users is! List) {
      return null;
    }

    return value.users?.first.avatar;
  }
}
