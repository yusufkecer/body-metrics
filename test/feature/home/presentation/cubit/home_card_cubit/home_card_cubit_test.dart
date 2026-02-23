import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeCardCubit', () {
    test('initial state is HomeCardInitial', () {
      expect(HomeCardCubit().state, const HomeCardInitial());
    });

    blocTest<HomeCardCubit, HomeCardState>(
      'initialize emits collapsed loaded state',
      build: HomeCardCubit.new,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateChart: true,
          shouldAnimateList: true,
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'dataListOnPressed toggles list expansion',
      build: HomeCardCubit.new,
      act: (cubit) {
        cubit
          ..dataListOnPressed()
          ..dataListOnPressed();
      },
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.list,
          shouldAnimateList: true,
          shouldAnimateChart: false,
        ),
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateList: false,
          shouldAnimateChart: true,
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'chartOnPressed toggles chart expansion',
      build: HomeCardCubit.new,
      act: (cubit) {
        cubit
          ..chartOnPressed()
          ..chartOnPressed();
      },
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.chart,
          shouldAnimateChart: true,
          shouldAnimateList: false,
        ),
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateChart: false,
          shouldAnimateList: true,
        ),
      ],
    );

    test('adjustLength returns max 2', () {
      final cubit = HomeCardCubit();

      expect(cubit.adjustLength(0), 0);
      expect(cubit.adjustLength(1), 1);
      expect(cubit.adjustLength(2), 2);
      expect(cubit.adjustLength(10), 2);
    });
  });
}
