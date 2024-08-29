part of 'onboard_cubit.dart';

sealed class OnboardState extends Equatable {
  const OnboardState(this.introKey);

  final GlobalKey<IntroductionScreenState> introKey;
  @override
  List<Object> get props => [introKey];
}

final class OnboardInitial extends OnboardState {
  const OnboardInitial(super.introKey);
}
