import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/onboard/domain/index.dart';

final class OnboardRepository implements BaseUseCase<bool, OnboardEntity> {
  OnboardRepository();

  @override
  Future<bool>? execute() {
    throw UnimplementedError();
  }

  @override
  Future<bool>? executeWithParams(OnboardEntity params) {
    throw UnimplementedError();
  }
}
