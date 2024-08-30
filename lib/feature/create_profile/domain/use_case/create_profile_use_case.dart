part of '../../presentation/create_profile.dart';

@injectable
@immutable
final class CreateProfileUseCase implements BaseUseCase<bool?, User> {
  final CreateProfileRepository _repository;

  const CreateProfileUseCase(this._repository);

  @override
  Future<bool?> execute() async {
    return null;
  }

  @override
  Future<bool?> executeWithParams(User params) {
    return _repository.executeWithParams(params);
  }
}
