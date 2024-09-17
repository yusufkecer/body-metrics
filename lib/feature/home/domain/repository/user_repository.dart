part of '../../presentation/home.dart';

@immutable
final class UserRepository implements BaseUseCase<int?, AppModel> {
  @override
  Future<int?>? execute() {
    throw UnimplementedError();
  }

  @override
  Future<int?>? executeWithParams(AppModel params) {
    throw UnimplementedError();
  }
}
