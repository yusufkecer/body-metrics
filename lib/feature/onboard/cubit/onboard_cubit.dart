import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:introduction_screen/introduction_screen.dart';

part 'onboard_state.dart';

@injectable
final class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit() : super(OnboardInitial(GlobalKey<IntroductionScreenState>()));

  void skip(int index) {
    state.introKey.currentState?.animateScroll(index);
  }
}
