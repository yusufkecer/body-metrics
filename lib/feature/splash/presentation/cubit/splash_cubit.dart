part of '../splash.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._useCase) : super(const SplashInitial());

  final SplashUseCase _useCase;

  Future<AppModel?> init() async {
    return _useCase.execute();
  }

  Future<User?> userValues(ParamsEntity params) async {
    return _useCase.executeWithParams(params);
  }
}
