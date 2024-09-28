part of '../splash.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  final appModel = Locator.sl<SplashUseCase>();

  Future<AppModel?> init() async {
    return appModel.execute();
  }

  Future<String?> userValues(ParamsEntity params) async {
    return appModel.executeWithParams(params);
  }
}
