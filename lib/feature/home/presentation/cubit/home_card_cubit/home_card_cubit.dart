import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_card_state.dart';

@injectable
class HomeCardCubit extends Cubit<HomeCardState> {
  HomeCardCubit() : super(const HomeCardInitial());

  void dataListOnPressed() {
    final currentState = state;
    if (currentState is HomeCardLoaded) {
      final newExpandedCard = currentState.expandedCard == ExpandedCard.list
          ? ExpandedCard.none
          : ExpandedCard.list;

      emit(HomeCardLoaded(
        expandedCard: newExpandedCard,
        shouldAnimateList: newExpandedCard == ExpandedCard.list,
        shouldAnimateChart: newExpandedCard != ExpandedCard.list,
      ));
    } else {
      emit(const HomeCardLoaded(
        expandedCard: ExpandedCard.list,
        shouldAnimateList: true,
        shouldAnimateChart: false,
      ));
    }
  }

  void chartOnPressed() {
    final currentState = state;
    if (currentState is HomeCardLoaded) {
      final newExpandedCard = currentState.expandedCard == ExpandedCard.chart
          ? ExpandedCard.none
          : ExpandedCard.chart;

      emit(
        HomeCardLoaded(
          expandedCard: newExpandedCard,
          shouldAnimateChart: newExpandedCard == ExpandedCard.chart,
          shouldAnimateList: newExpandedCard != ExpandedCard.chart,
        ),
      );
    } else {
      emit(
        const HomeCardLoaded(
          expandedCard: ExpandedCard.chart,
          shouldAnimateChart: true,
          shouldAnimateList: false,
        ),
      );
    }
  }

  void initialize() {
    emit(
      const HomeCardLoaded(
        expandedCard: ExpandedCard.none,
        shouldAnimateChart: true,
        shouldAnimateList: true,
      ),
    );
  }

  int adjustLength(int length) {
    return length >= 2 ? 2 : length;
  }
}

enum ExpandedCard {
  none,
  list,
  chart,
}
