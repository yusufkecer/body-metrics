import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/height/domain/use_case/save_height_use_case.dart';
import 'package:bodymetrics/feature/height/presentation/cubit/save_height_cubit/save_height_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SaveHeightUseCase>()])
import 'save_height_cubit_test.mocks.dart';

void main() {
  late MockSaveHeightUseCase mockSaveHeightUseCase;
  late SaveHeightCubit cubit;

  setUp(() {
    mockSaveHeightUseCase = MockSaveHeightUseCase();
    cubit = SaveHeightCubit(mockSaveHeightUseCase);
    AppUtil.currentUserId = 1;
  });

  tearDown(() {
    cubit.close();
  });

  group('SaveHeightCubit', () {
    test('initial state is SaveHeightInitial', () {
      expect(cubit.state, isA<SaveHeightInitial>());
    });

    blocTest<SaveHeightCubit, SaveHeightState>(
      'saveHeight emits [SaveHeightLoading, SaveHeightSuccess] when use case returns true',
      setUp: () {
        when(mockSaveHeightUseCase.executeWithParams(params: anyNamed('params')))
            .thenAnswer((_) async => true);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveHeight(180),
      expect: () => [
        isA<SaveHeightLoading>(),
        isA<SaveHeightSuccess>(),
      ],
      verify: (_) {
        verify(mockSaveHeightUseCase.executeWithParams(
          params: const User(id: 1, height: 180),
        )).called(1);
      },
    );

    blocTest<SaveHeightCubit, SaveHeightState>(
      'saveHeight emits [SaveHeightLoading, SaveHeightError] when use case returns false',
      setUp: () {
        when(mockSaveHeightUseCase.executeWithParams(params: anyNamed('params')))
            .thenAnswer((_) async => false);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveHeight(180),
      expect: () => [
        isA<SaveHeightLoading>(),
        isA<SaveHeightError>(),
      ],
    );

    blocTest<SaveHeightCubit, SaveHeightState>(
      'saveHeight emits [SaveHeightLoading, SaveHeightError] when use case returns null',
      setUp: () {
        when(mockSaveHeightUseCase.executeWithParams(params: anyNamed('params')))
            .thenAnswer((_) async => null);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveHeight(180),
      expect: () => [
        isA<SaveHeightLoading>(),
        isA<SaveHeightError>(),
      ],
    );
  });
}
