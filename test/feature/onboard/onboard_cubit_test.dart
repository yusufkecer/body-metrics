import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/onboard/presentation/cubit/onboard_cubit.dart';
import 'package:bodymetrics/feature/onboard/presentation/onboard.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: must_be_immutable
class FakeOnboardUseCase implements UseCase<bool, AppModel> {
  bool? returnValue;
  Exception? exception;
  final calls = <AppModel?>[];

  Exception? get setupThrow => exception;

  @override
  Future<bool?> executeWithParams({AppModel? params}) async {
    calls.add(params);
    if (exception.isNotNull) throw exception!;
    return returnValue;
  }

  void reset() {
    returnValue = null;
    exception = null;
    calls.clear();
  }
}

void main() {
  group('OnboardCubit Tests', () {
    late OnboardCubit cubit;
    late FakeOnboardUseCase fakeUseCase;

    setUp(() {
      fakeUseCase = FakeOnboardUseCase();
      cubit = OnboardCubit(fakeUseCase);
    });

    tearDown(() {
      cubit.close();
      fakeUseCase.reset();
    });

    test('initial state should be OnboardInitial with currentPage 0', () {
      expect(cubit.state, const OnboardInitial());
    });

    group('updateIndex', () {
      blocTest<OnboardCubit, OnboardState>(
        'should emit new state when updateIndex is called',
        build: () => cubit,
        act: (cubit) => cubit.updateIndex(2),
        expect: () => [const OnboardInitial(currentPage: 2)],
      );

      blocTest<OnboardCubit, OnboardState>(
        'should handle multiple updateIndex calls',
        build: () => cubit,
        act: (cubit) {
          cubit.updateIndex(1);
          cubit.updateIndex(3);
        },
        expect: () => [
          const OnboardInitial(currentPage: 1),
          const OnboardInitial(currentPage: 3),
        ],
      );
    });

    group('done', () {
      const testAppModel = AppModel(
        isCompleteOnboard: true,
        activeUser: 1,
        page: Pages.avatarPage,
      );

      test('should return true when use case succeeds', () async {
        // Arrange
        fakeUseCase.returnValue = true;

        // Act
        final result = await cubit.done(testAppModel);

        // Assert
        expect(result, true);
        expect(fakeUseCase.calls.length, 1);
        expect(fakeUseCase.calls.first, testAppModel);
      });

      test('should return false when use case returns false', () async {
        // Arrange
        fakeUseCase.returnValue = false;

        // Act
        final result = await cubit.done(testAppModel);

        // Assert
        expect(result, false);
        expect(fakeUseCase.calls.length, 1);
      });

      test('should return false when use case returns null', () async {
        // Arrange
        fakeUseCase.returnValue = null;

        // Act
        final result = await cubit.done(testAppModel);

        // Assert
        expect(result, false);
        expect(fakeUseCase.calls.length, 1);
      });

      test('should propagate exception when use case throws', () async {
        // Arrange
        final exception = Exception('Test error');
        fakeUseCase.exception = exception;

        // Act & Assert
        expect(() => cubit.done(testAppModel), throwsA(exception));
        expect(fakeUseCase.calls.length, 1);
      });
    });

    group('OnboardState', () {
      test('should have correct equality', () {
        const state1 = OnboardInitial(currentPage: 1);
        const state2 = OnboardInitial(currentPage: 1);
        const state3 = OnboardInitial(currentPage: 2);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('should have correct props', () {
        const state = OnboardInitial(currentPage: 5);
        expect(state.props, [5]);
      });
    });
  });
}
