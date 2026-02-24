import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>(), MockSpec<SyncLocalDataUseCase>()])
import 'register_cubit_test.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockSyncLocalDataUseCase mockSyncLocalDataUseCase;
  late RegisterCubit cubit;

  setUp(() {
    mockAuthService = MockAuthService();
    mockSyncLocalDataUseCase = MockSyncLocalDataUseCase();
    cubit = RegisterCubit(mockAuthService, mockSyncLocalDataUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('RegisterCubit', () {
    test('initial state is RegisterInitial', () {
      expect(cubit.state, isA<RegisterInitial>());
    });

    blocTest<RegisterCubit, RegisterState>(
      'register emits [RegisterLoading, RegisterSuccess] on success and calls sync if currentUserId is not null',
      setUp: () {
        AppUtil.currentUserId = 1;
        when(mockAuthService.register(email: 'test@test.com', password: 'password'))
            .thenAnswer((_) async {});
        when(mockSyncLocalDataUseCase.execute()).thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.register(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<RegisterLoading>(),
        isA<RegisterSuccess>(),
      ],
      verify: (_) {
        verify(mockAuthService.register(email: 'test@test.com', password: 'password')).called(1);
        verify(mockSyncLocalDataUseCase.execute()).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'register emits [RegisterLoading, RegisterSuccess] on success and does NOT call sync if currentUserId is null',
      setUp: () {
        AppUtil.currentUserId = null;
        when(mockAuthService.register(email: 'test@test.com', password: 'password'))
            .thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.register(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<RegisterLoading>(),
        isA<RegisterSuccess>(),
      ],
      verify: (_) {
        verify(mockAuthService.register(email: 'test@test.com', password: 'password')).called(1);
        verifyNever(mockSyncLocalDataUseCase.execute());
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'register emits [RegisterLoading, RegisterError] on auth failure',
      setUp: () {
        when(mockAuthService.register(email: 'test@test.com', password: 'password'))
            .thenThrow(Exception('Registration Failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.register(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<RegisterLoading>(),
        isA<RegisterError>().having((s) => s.message, 'message', 'Exception: Registration Failed'),
      ],
      verify: (_) {
        verify(mockAuthService.register(email: 'test@test.com', password: 'password')).called(1);
        verifyNever(mockSyncLocalDataUseCase.execute());
      },
    );
  });
}
