import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/onboard/domain/repository/onboard_repository.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:injectable/injectable.dart';

@injectable
final class OnboardUseCase implements BaseUseCase<bool, AppModel> {
  final onboardRepository = Locator.sl<OnboardRepository>();
  @override
  Future<bool>? execute() {
    return null;
  }

  @override
  Future<bool>? executeWithParams(AppModel params) {
    return onboardRepository.executeWithParams(params);
  }
}
