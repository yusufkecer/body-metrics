part of '../splash.dart';

sealed class SplashState extends Equatable {
  const SplashState({this.appModel});

  final AppModel? appModel;

  @override
  List<Object?> get props => [appModel];
}

final class SplashInitial extends SplashState {
  const SplashInitial({super.appModel});
}
