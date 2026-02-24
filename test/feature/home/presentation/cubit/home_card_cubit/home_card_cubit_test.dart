import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/home_card_cubit/home_card_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeCardCubit', () {
    late HomeCardCubit cubit;

    setUp(() {
      cubit = HomeCardCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is HomeCardInitial', () {
      expect(cubit.state, isA<HomeCardInitial>());
    });

    blocTest<HomeCardCubit, HomeCardState>(
      'initialize emits HomeCardLoaded with default values',
      build: () => cubit,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateList: true,
          shouldAnimateChart: true,
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'dataListOnPressed emits HomeCardLoaded with ExpandedCard.list when current state is NOT HomeCardLoaded',
      build: () => cubit,
      act: (cubit) => cubit.dataListOnPressed(),
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.list,
          shouldAnimateList: true,
          shouldAnimateChart: false,
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'dataListOnPressed toggles between ExpandedCard.list and ExpandedCard.none when current state IS HomeCardLoaded',
      build: () => cubit,
      seed: () => const HomeCardLoaded(
        expandedCard: ExpandedCard.none,
        shouldAnimateList: true,
        shouldAnimateChart: true,
      ),
      act: (cubit) {
        cubit
          ..dataListOnPressed() // expands list
          ..dataListOnPressed(); // collapses list
      },
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.list,
          shouldAnimateList: true,
          shouldAnimateChart: false,
        ),
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateList:
              false, // from logic: newExpandedCard == ExpandedCard.list ? true : false => false
          shouldAnimateChart:
              true, // from logic: newExpandedCard != ExpandedCard.list ? true : false => true
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'chartOnPressed emits HomeCardLoaded with ExpandedCard.chart when current state is NOT HomeCardLoaded',
      build: () => cubit,
      act: (cubit) => cubit.chartOnPressed(),
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.chart,
          shouldAnimateChart: true,
          shouldAnimateList: false,
        ),
      ],
    );

    blocTest<HomeCardCubit, HomeCardState>(
      'chartOnPressed toggles between ExpandedCard.chart and ExpandedCard.none when current state IS HomeCardLoaded',
      build: () => cubit,
      seed: () => const HomeCardLoaded(
        expandedCard: ExpandedCard.none,
        shouldAnimateList: true,
        shouldAnimateChart: true,
      ),
      act: (cubit) {
        cubit
          ..chartOnPressed() // expands chart
          ..chartOnPressed(); // collapses chart
      },
      expect: () => [
        const HomeCardLoaded(
          expandedCard: ExpandedCard.chart,
          shouldAnimateChart: true,
          shouldAnimateList: false,
        ),
        const HomeCardLoaded(
          expandedCard: ExpandedCard.none,
          shouldAnimateChart:
              false, // from logic: newExpandedCard == ExpandedCard.chart => false
          shouldAnimateList:
              true, // from logic: newExpandedCard != ExpandedCard.chart => true
        ),
      ],
    );

    test('adjustLength limits length to maximum of 2', () {
      expect(cubit.adjustLength(0), 0);
      expect(cubit.adjustLength(1), 1);
      expect(cubit.adjustLength(2), 2);
      expect(cubit.adjustLength(5), 2);
    });
  });
}
