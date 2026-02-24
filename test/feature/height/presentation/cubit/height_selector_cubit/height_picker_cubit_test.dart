import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/height_selector_cubit/height_picker_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeightSelectorCubit', () {
    late HeightSelectorCubit cubit;

    setUp(() {
      cubit = HeightSelectorCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is HeightSelectorUpdateHeight with null/0 values', () {
      expect(cubit.state, isA<HeightSelectorUpdateHeight>());
      expect(cubit.state.userHeight, isNull);
      expect(cubit.state.height, isNull);
    });

    blocTest<HeightSelectorCubit, HeightSelectorState>(
      'updateHeight calculates correct position and height',
      build: () => cubit,
      act: (cubit) => cubit.updateHeight(10, 100, 200),
      expect: () {
        // page = 10.0, minValue = 100, maxValue = 200
        // position = 10 + 100 + 1 = 111
        // _calculateHeight(111, minValue: 65, maxValue: 252) => ((111 * 2) * (252 - 65)) / 233 = (222 * 187) / 233 = 41514 / 233 = 178.17...
        const expectedHeight = ((111 * 2) * (252 - 65)) / 233;

        return [
          isA<HeightSelectorUpdateHeight>()
              .having((s) => s.userHeight, 'userHeight', 111)
              .having((s) => s.height, 'height', expectedHeight),
        ];
      },
    );

    blocTest<HeightSelectorCubit, HeightSelectorState>(
      'updateHeight does not emit if position exceeds maxValue',
      build: () => cubit,
      act: (cubit) => cubit.updateHeight(150, 100, 200),
      expect: () =>
          <HeightSelectorState>[], // position = 150 + 100 + 1 = 251 > 200
    );
  });
}
