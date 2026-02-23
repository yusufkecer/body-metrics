import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserUseCase extends Mock implements UserUseCase {}

void main() {
  late MockUserUseCase mockUserUseCase;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
  });

  group('UserCubit', () {
    blocTest<UserCubit, UserState>(
      'emits [UserLoaded] with safe defaults when user is returned',
      setUp: () {
        when(mockUserUseCase.getCurrentUser()).thenAnswer(
          (_) async => const User(
            id: 7,
            name: null,
            surname: null,
            avatar: null,
            gender: GenderValue.male,
            height: 182,
          ),
        );
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [
        const UserLoaded(
          user: User(
            id: 7,
            name: '',
            surname: '',
            avatar: '',
            gender: GenderValue.male,
            height: 182,
          ),
        ),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserError(user_not_found)] when current user is null',
      setUp: () {
        when(mockUserUseCase.getCurrentUser()).thenAnswer((_) async => null);
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [
        const UserError(message: LocaleKeys.exception_user_not_found),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserError(generic)] when use case throws',
      setUp: () {
        when(mockUserUseCase.getCurrentUser()).thenThrow(Exception('boom'));
      },
      build: () => UserCubit(mockUserUseCase),
      expect: () => [
        const UserError(message: LocaleKeys.exception_generic_error),
      ],
    );
  });
}
