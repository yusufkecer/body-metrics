abstract interface class BaseUseCase<T, Params> {
  T executeWithParams(Params params);
  T execute();
}
