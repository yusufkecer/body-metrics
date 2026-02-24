import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<OnboardUseCase>()])
import 'onboard_cubit_test.mocks.dart';

void main() {
  late MockOnboardUseCase mockOnboardUseCase;
  late OnboardCubit cubit;

  setUp(() {
    mockOnboardUseCase = MockOnboardUseCase();
    cubit = OnboardCubit(mockOnboardUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('OnboardCubit', () {
    test('initial state is OnboardInitial with currentPage 0', () {
      expect(cubit.state, isA<OnboardInitial>());
      expect(cubit.state.currentPage, 0);
    });

    blocTest<OnboardCubit, OnboardState>(
      'updateIndex emits OnboardInitial with updated index',
      build: () => cubit,
      act: (cubit) => cubit.updateIndex(2),
      expect: () => [
        isA<OnboardInitial>().having((s) => s.currentPage, 'currentPage', 2),
      ],
    );

    test('done returns true when use case returns true', () async {
      const tModel = AppModel(activeUser: 1, page: Pages.userGeneralInfo);
      when(
        mockOnboardUseCase.executeWithParams(params: tModel),
      ).thenAnswer((_) async => true);

      final result = await cubit.done(tModel);

      expect(result, true);
      verify(mockOnboardUseCase.executeWithParams(params: tModel)).called(1);
    });

    test('done returns false when use case returns null', () async {
      const tModel = AppModel(activeUser: 1, page: Pages.userGeneralInfo);
      when(
        mockOnboardUseCase.executeWithParams(params: tModel),
      ).thenAnswer((_) async => null);

      final result = await cubit.done(tModel);

      expect(result, false);
      verify(mockOnboardUseCase.executeWithParams(params: tModel)).called(1);
    });
  });
}
