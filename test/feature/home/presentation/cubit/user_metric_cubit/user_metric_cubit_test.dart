import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_metric_use_case.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_metric_cubit/user_metric_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserMetricUseCase>()])
import 'user_metric_cubit_test.mocks.dart';

void main() {
  late MockUserMetricUseCase mockUserMetricUseCase;
  late UserMetricCubit cubit;

  setUp(() {
    mockUserMetricUseCase = MockUserMetricUseCase();
    cubit = UserMetricCubit(mockUserMetricUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('UserMetricCubit', () {
    test('initial state is UserMetricInitial', () {
      expect(cubit.state, isA<UserMetricInitial>());
    });

    const tUserMetrics = UserMetrics(
      userMetrics: [UserMetric(id: 1, userId: 1, weight: 70)],
    );

    blocTest<UserMetricCubit, UserMetricState>(
      'getUserMetric emits [UserMetricLoading, UserMetricSuccess] when use case returns data',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer((_) async => tUserMetrics);
      },
      build: () => cubit,
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        isA<UserMetricLoading>(),
        isA<UserMetricSuccess>().having(
          (s) => s.userMetric,
          'userMetric',
          tUserMetrics,
        ),
      ],
      verify: (_) {
        verify(
          mockUserMetricUseCase.executeWithParams(
            params: const UserMetric(userId: 1),
          ),
        ).called(1);
      },
    );

    blocTest<UserMetricCubit, UserMetricState>(
      'getUserMetric emits [UserMetricLoading, UserMetricError] when use case returns null',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer((_) async => null);
      },
      build: () => cubit,
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        isA<UserMetricLoading>(),
        isA<UserMetricError>().having(
          (s) => s.error,
          'error',
          'User metric not found',
        ),
      ],
    );

    blocTest<UserMetricCubit, UserMetricState>(
      'getUserMetric emits [UserMetricLoading, UserMetricError] when use case throws exception',
      setUp: () {
        when(
          mockUserMetricUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer((_) => Future.error(Exception('Failed')));
      },
      build: () => cubit,
      act: (cubit) => cubit.getUserMetric(1),
      expect: () => [
        isA<UserMetricLoading>(),
        isA<UserMetricError>().having(
          (s) => s.error,
          'error',
          LocaleKeys.exception_generic_error,
        ),
      ],
    );
  });
}
