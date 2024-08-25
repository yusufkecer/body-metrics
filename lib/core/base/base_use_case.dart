abstract interface class BaseUseCase<T, Params> {
  Future<T>? executeWithParams(Params params);
  Future<T>? execute();
}
