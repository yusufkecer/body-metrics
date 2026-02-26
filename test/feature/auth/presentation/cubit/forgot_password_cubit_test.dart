import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'forgot_password_cubit_test.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late ForgotPasswordCubit cubit;

  setUp(() {
    mockAuthService = MockAuthService();
    cubit = ForgotPasswordCubit(mockAuthService);
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgotPasswordCubit', () {
    test('initial state is ForgotPasswordInitial', () {
      expect(cubit.state, isA<ForgotPasswordInitial>());
    });

    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'sendCode emits [ForgotPasswordLoading, ForgotPasswordCodeSent] on success',
      setUp: () {
        when(mockAuthService.forgotPassword(email: 'test@test.com'))
            .thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.sendCode('test@test.com'),
      expect: () => [
        isA<ForgotPasswordLoading>(),
        isA<ForgotPasswordCodeSent>(),
      ],
      verify: (_) {
        verify(mockAuthService.forgotPassword(email: 'test@test.com')).called(1);
      },
    );

    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'sendCode emits [ForgotPasswordLoading, ForgotPasswordError] on failure',
      setUp: () {
        when(mockAuthService.forgotPassword(email: 'test@test.com'))
            .thenThrow(Exception('Send code failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.sendCode('test@test.com'),
      expect: () => [
        isA<ForgotPasswordLoading>(),
        isA<ForgotPasswordError>().having((s) => s.message, 'message', 'Exception: Send code failed'),
      ],
      verify: (_) {
        verify(mockAuthService.forgotPassword(email: 'test@test.com')).called(1);
      },
    );

    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'resetPassword emits [ForgotPasswordLoading, ForgotPasswordSuccess] on success',
      setUp: () {
        when(mockAuthService.resetPassword(
          email: 'test@test.com',
          token: '123456',
          password: 'new_password',
        )).thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.resetPassword(
        email: 'test@test.com',
        token: '123456',
        password: 'new_password',
      ),
      expect: () => [
        isA<ForgotPasswordLoading>(),
        isA<ForgotPasswordSuccess>(),
      ],
      verify: (_) {
        verify(mockAuthService.resetPassword(
          email: 'test@test.com',
          token: '123456',
          password: 'new_password',
        )).called(1);
      },
    );

    blocTest<ForgotPasswordCubit, ForgotPasswordState>(
      'resetPassword emits [ForgotPasswordLoading, ForgotPasswordError] on failure',
      setUp: () {
        when(mockAuthService.resetPassword(
          email: 'test@test.com',
          token: '123456',
          password: 'new_password',
        )).thenThrow(Exception('Reset failed'));
      },
      build: () => cubit,
      act: (cubit) => cubit.resetPassword(
        email: 'test@test.com',
        token: '123456',
        password: 'new_password',
      ),
      expect: () => [
        isA<ForgotPasswordLoading>(),
        isA<ForgotPasswordError>().having((s) => s.message, 'message', 'Exception: Reset failed'),
      ],
      verify: (_) {
        verify(mockAuthService.resetPassword(
          email: 'test@test.com',
          token: '123456',
          password: 'new_password',
        )).called(1);
      },
    );
  });
}
