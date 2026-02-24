import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/domain/index.dart';
import 'package:bodymetrics/feature/user_general_info/presentation/cubit/user_info_form_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CreateProfileUseCase>()])
import 'user_info_form_cubit_test.mocks.dart';

void main() {
  late MockCreateProfileUseCase mockCreateProfileUseCase;
  late UserInfoFormCubit cubit;

  setUp(() {
    mockCreateProfileUseCase = MockCreateProfileUseCase();
    cubit = UserInfoFormCubit(mockCreateProfileUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('UserInfoFormCubit', () {
    test('initial state is UserInfoFormCubitFormEmpty with true', () {
      expect(cubit.state, isA<UserInfoFormCubitFormEmpty>());
      expect(cubit.state.isFormEmpty, true);
    });

    blocTest<UserInfoFormCubit, UserInfoFormCubitState>(
      'setFormEmpty emits UserInfoFormCubitFormEmpty with updated param',
      build: () => cubit,
      act: (cubit) => cubit.setFormEmpty(param: false),
      expect: () => [
        isA<UserInfoFormCubitFormEmpty>().having(
          (s) => s.isFormEmpty,
          'isFormEmpty',
          false,
        ),
      ],
    );

    const tUser = User(id: 1, name: 'John');

    blocTest<UserInfoFormCubit, UserInfoFormCubitState>(
      'saveUserInfo emits [Loading, Success] when use case returns true',
      setUp: () {
        when(
          mockCreateProfileUseCase.executeWithParams(params: tUser),
        ).thenAnswer((_) async => true);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveUserInfo(tUser),
      expect: () => [
        isA<UserInfoFormCubitLoading>(),
        isA<UserInfoFormCubitSuccess>(),
      ],
      verify: (_) {
        verify(
          mockCreateProfileUseCase.executeWithParams(params: tUser),
        ).called(1);
      },
    );

    blocTest<UserInfoFormCubit, UserInfoFormCubitState>(
      'saveUserInfo emits [Loading, Error] when use case returns false',
      setUp: () {
        when(
          mockCreateProfileUseCase.executeWithParams(params: tUser),
        ).thenAnswer((_) async => false);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveUserInfo(tUser),
      expect: () => [
        isA<UserInfoFormCubitLoading>(),
        isA<UserInfoFormCubitError>().having(
          (s) => s.error,
          'error',
          LocaleKeys.exception_user_not_created,
        ),
      ],
    );

    blocTest<UserInfoFormCubit, UserInfoFormCubitState>(
      'saveUserInfo emits [Loading, Error] when use case returns null',
      setUp: () {
        when(
          mockCreateProfileUseCase.executeWithParams(params: tUser),
        ).thenAnswer((_) async => null);
      },
      build: () => cubit,
      act: (cubit) => cubit.saveUserInfo(tUser),
      expect: () => [
        isA<UserInfoFormCubitLoading>(),
        isA<UserInfoFormCubitError>().having(
          (s) => s.error,
          'error',
          LocaleKeys.exception_user_not_created,
        ),
      ],
    );
  });
}
