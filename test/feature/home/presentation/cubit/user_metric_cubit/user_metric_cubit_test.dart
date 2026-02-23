import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_metric_use_case.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserMetricUseCase extends Mock implements UserMetricUseCase {}

void main() {
  late MockUserMetricUseCase mockUserMetricUseCase;

  setUp(() {
    mockUserMetricUseCase = MockUserMetricUseCase();
  });

  group('UserMetricCubit', () {
    test('initial state is UserMetricInitial', () {
      expect(UserMetricCubit(mockUserMetricUseCase).state, const UserMetricInitial());
    });

    blocTest<UserMetricCubit, UserMetricState>(
      'emits [UserMetricLoading, UserMetricSuccess] when use case returns data',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer(
          (_) async => const UserMetrics(
            userMetrics: [
              UserMetric(userId: 1, height: 180, weight: 74.0, bmi: 22.8),
            ],
          ),
        );
      },
      build: () => UserMetricCubit(mockUserMetricUseCase),
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        const UserMetricLoading(),
        const UserMetricSuccess(
          userMetric: UserMetrics(
            userMetrics: [
              UserMetric(userId: 1, height: 180, weight: 74.0, bmi: 22.8),
            ],
          ),
        ),
      ],
      verify: (_) {
        verify(
          mockUserMetricUseCase.executeWithParams(params: const UserMetric(userId: 1)),
        ).called(1);
      },
    );

    blocTest<UserMetricCubit, UserMetricState>(
      'emits [UserMetricLoading, UserMetricError] when data is null',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer((_) async => null);
      },
      build: () => UserMetricCubit(mockUserMetricUseCase),
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        const UserMetricLoading(),
        const UserMetricError(error: 'User metric not found'),
      ],
    );

    blocTest<UserMetricCubit, UserMetricState>(
      'emits [UserMetricLoading, UserMetricError(generic)] on exception',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenThrow(Exception('db error'));
      },
      build: () => UserMetricCubit(mockUserMetricUseCase),
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        const UserMetricLoading(),
        const UserMetricError(error: LocaleKeys.exception_generic_error),
      ],
    );
  });
}
