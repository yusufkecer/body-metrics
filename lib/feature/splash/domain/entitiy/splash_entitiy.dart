part of '../../splash.dart';

@immutable
final class SplashEntitiy extends Equatable {
  final Pages? page;
  final bool? onboardingCompleted;

  const SplashEntitiy({this.page, this.onboardingCompleted});

  @override
  List<Object?> get props => throw UnimplementedError();
}
