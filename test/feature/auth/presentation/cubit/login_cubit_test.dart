import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>(), MockSpec<SyncLocalDataUseCase>()])
import 'login_cubit_test.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockSyncLocalDataUseCase mockSyncLocalDataUseCase;
  late LoginCubit cubit;

  setUp(() {
    mockAuthService = MockAuthService();
    mockSyncLocalDataUseCase = MockSyncLocalDataUseCase();
    cubit = LoginCubit(mockAuthService, mockSyncLocalDataUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(cubit.state, isA<LoginInitial>());
    });

    blocTest<LoginCubit, LoginState>(
      'login emits [LoginLoading, LoginSuccess] on success',
      setUp: () {
        when(mockAuthService.login(email: 'test@test.com', password: 'password'))
            .thenAnswer((_) async {});
        when(mockSyncLocalDataUseCase.execute()).thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.login(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginSuccess>(),
      ],
      verify: (_) {
        verify(mockAuthService.login(email: 'test@test.com', password: 'password')).called(1);
        verify(mockSyncLocalDataUseCase.execute()).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'login emits [LoginLoading, LoginError] on auth failure',
      setUp: () {
        when(mockAuthService.login(email: 'test@test.com', password: 'password'))
            .thenThrow(Exception('Auth Failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.login(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having((s) => s.message, 'message', 'Exception: Auth Failed'),
      ],
      verify: (_) {
        verify(mockAuthService.login(email: 'test@test.com', password: 'password')).called(1);
        verifyNever(mockSyncLocalDataUseCase.execute());
      },
    );

    blocTest<LoginCubit, LoginState>(
      'login emits [LoginLoading, LoginError] on sync failure',
      setUp: () {
        when(mockAuthService.login(email: 'test@test.com', password: 'password'))
            .thenAnswer((_) async {});
        when(mockSyncLocalDataUseCase.execute()).thenThrow(Exception('Sync Failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.login(email: 'test@test.com', password: 'password'),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>().having((s) => s.message, 'message', 'Exception: Sync Failed'),
      ],
      verify: (_) {
        verify(mockAuthService.login(email: 'test@test.com', password: 'password')).called(1);
        verify(mockSyncLocalDataUseCase.execute()).called(1);
      },
    );
  });
}
