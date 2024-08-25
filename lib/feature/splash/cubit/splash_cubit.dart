part of '../splash.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<AppModel> init() async {
    final appModel = Locator.sl<SplashRepository>();
    return appModel.execute();
  }
}
