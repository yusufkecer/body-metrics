part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState({this.onboardingCompleted});

  final bool? onboardingCompleted;
  //giriş yapan son kullanıcı bilgileri alınacak
//sayfa bilgileri de buradan yönetilecek
  @override
  List<Object?> get props => [onboardingCompleted];
}

final class SplashInitial extends SplashState {
  const SplashInitial({super.onboardingCompleted});
}
