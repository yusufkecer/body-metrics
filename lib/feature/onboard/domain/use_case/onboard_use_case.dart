part of '../../presentation/onboard.dart';

@injectable
@immutable
final class OnboardUseCase implements BaseUseCase<bool, bool, AppModel> {
  final onboardRepository = Locator.sl<OnboardRepository>();
  @override
  Future<bool>? execute() {
    return null;
  }

  @override
  Future<bool?> executeWithParams(AppModel params) async {
    final result = await onboardRepository.executeWithParams(params);
    return result.convertBoolResult;
  }
}
