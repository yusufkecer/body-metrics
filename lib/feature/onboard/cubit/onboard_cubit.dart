import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'onboard_state.dart';

@injectable
final class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit() : super(const OnboardInitial());

  void skip(int index, IntroKey key) {
    key.currentState?.controller.jumpToPage(index);
  }

  void updateIndex(int index) {
    emit(OnboardInitial(currentPage: index));
    '${state.currentPage} $index'.log;
  }
}
