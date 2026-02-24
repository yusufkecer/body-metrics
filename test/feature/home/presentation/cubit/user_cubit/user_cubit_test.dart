import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserUseCase>()])
import 'user_cubit_test.mocks.dart';

void main() {
  late MockUserUseCase mockUserUseCase;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
  });

  group('UserCubit', () {
    test('initial state is UserLoading', () async {
      when(
        mockUserUseCase.getCurrentUser(),
      ).thenAnswer((_) async => const User(id: 1));
      final cubit = UserCubit(mockUserUseCase);
      expect(cubit.state, isA<UserLoading>());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await cubit.close();
    });

    blocTest<UserCubit, UserState>(
      'emits [UserLoaded] when getUserAndHistory is successful',
      setUp: () {
        when(mockUserUseCase.getCurrentUser()).thenAnswer(
          (_) async => const User(id: 1, name: 'John', surname: 'Doe'),
        );
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [
        isA<UserLoaded>()
            .having((s) => s.user.id, 'user.id', 1)
            .having((s) => s.user.name, 'user.name', 'John'),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserError] when getCurrentUser returns null',
      setUp: () {
        when(mockUserUseCase.getCurrentUser()).thenAnswer((_) async => null);
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [isA<UserError>()],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserError] when getCurrentUser throws an exception',
      setUp: () {
        when(
          mockUserUseCase.getCurrentUser(),
        ).thenAnswer((_) => Future.error(Exception('Failed to fetch')));
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [isA<UserError>()],
    );
  });
}
