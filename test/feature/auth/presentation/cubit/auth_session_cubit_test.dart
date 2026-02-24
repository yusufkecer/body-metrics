import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/feature/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthService>()])
import 'auth_session_cubit_test.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late AuthSessionCubit cubit;

  setUp(() {
    mockAuthService = MockAuthService();
    cubit = AuthSessionCubit(mockAuthService);
  });

  tearDown(() {
    cubit.close();
  });

  group('AuthSessionCubit', () {
    test('initial state is AuthSessionLoading', () {
      expect(cubit.state, isA<AuthSessionLoading>());
    });

    blocTest<AuthSessionCubit, AuthSessionState>(
      'loadSession emits [AuthSessionLoading, AuthSessionAuthenticated] when hasSession returns true',
      setUp: () {
        when(mockAuthService.hasSession()).thenAnswer((_) async => true);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadSession(),
      expect: () => [
        isA<AuthSessionLoading>(),
        isA<AuthSessionAuthenticated>(),
      ],
      verify: (_) {
        verify(mockAuthService.hasSession()).called(1);
      },
    );

    blocTest<AuthSessionCubit, AuthSessionState>(
      'loadSession emits [AuthSessionLoading, AuthSessionUnauthenticated] when hasSession returns false',
      setUp: () {
        when(mockAuthService.hasSession()).thenAnswer((_) async => false);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadSession(),
      expect: () => [
        isA<AuthSessionLoading>(),
        isA<AuthSessionUnauthenticated>(),
      ],
      verify: (_) {
        verify(mockAuthService.hasSession()).called(1);
      },
    );

    blocTest<AuthSessionCubit, AuthSessionState>(
      'logout emits [AuthSessionUnauthenticated] and calls logoutLocal',
      setUp: () {
        when(mockAuthService.logoutLocal()).thenAnswer((_) async {});
      },
      build: () => cubit,
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<AuthSessionUnauthenticated>(),
      ],
      verify: (_) {
        verify(mockAuthService.logoutLocal()).called(1);
      },
    );
  });
}
