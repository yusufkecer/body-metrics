// ignore: one_member_abstracts
abstract interface class BaseUseCase<T, Params> {
  T? execute(Params params);
}
