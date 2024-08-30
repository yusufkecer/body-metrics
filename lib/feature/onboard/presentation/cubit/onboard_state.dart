part of '../onboard.dart';

sealed class OnboardState extends Equatable {
  const OnboardState({this.currentPage = 0});

  final int currentPage;

  @override
  List<Object?> get props => [currentPage];
}

class OnboardInitial extends OnboardState {
  const OnboardInitial({super.currentPage});
}
