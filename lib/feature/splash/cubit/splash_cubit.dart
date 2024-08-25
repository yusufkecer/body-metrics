part of '../splash.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> init() async {
    final appModel = Locator.sl<SplashRepository>();
    await appModel.execute();
  }
}
