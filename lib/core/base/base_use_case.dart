abstract interface class BaseUseCase<T, Params> {
  T? execute(Params params);
  T? executeAll(Params params);
}
