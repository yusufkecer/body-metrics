part of '../../create_profile.dart';

@injectable
final class CreateProfileUseCase implements BaseUseCase<bool?, User> {
  final CreateProfileRepository _repository;

  CreateProfileUseCase(this._repository);

  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<bool?> executeWithParams(User params) {
    return _repository.executeWithParams(params);
  }
}
