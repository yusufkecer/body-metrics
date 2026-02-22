import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:bodymetrics/feature/gender/presentation/cubit/gender_cubit/gender_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SaveGenderUseCase>()])
import 'gender_cubit_test.mocks.dart';

void main() {
  late MockSaveGenderUseCase mockSaveGenderUseCase;
  late GenderCubit genderCubit;

  setUp(() {
    mockSaveGenderUseCase = MockSaveGenderUseCase();
    genderCubit = GenderCubit(mockSaveGenderUseCase);
  });

  tearDown(() {
    genderCubit.close();
  });

  group('GenderCubit', () {
    test('initial state is GenderInitial', () {
      expect(genderCubit.state, isA<GenderInitial>());
    });

    blocTest<GenderCubit, GenderState>(
      'emits [GenderSelected] when selectGender is called',
      build: () => genderCubit,
      act: (cubit) => cubit.selectGender(GenderValue.male),
      expect: () => [const GenderSelected(GenderValue.male)],
    );

    blocTest<GenderCubit, GenderState>(
      'emits [GenderSelected, GenderInitial] when selectGender is called twice with same value',
      build: () => genderCubit,
      act: (cubit) {
        cubit
          ..selectGender(GenderValue.male)
          ..selectGender(GenderValue.male);
      },
      expect: () => [
        const GenderSelected(GenderValue.male),
        const GenderInitial(),
      ],
    );

    blocTest<GenderCubit, GenderState>(
      'emits [GenderSelected(male), GenderSelected(female)] when selectGender is called with different values',
      build: () => genderCubit,
      act: (cubit) {
        cubit
          ..selectGender(GenderValue.male)
          ..selectGender(GenderValue.female);
      },
      expect: () => [
        const GenderSelected(GenderValue.male),
        const GenderSelected(GenderValue.female),
      ],
    );

    blocTest<GenderCubit, GenderState>(
      'emits [GenderError] when saveGender is called without selection',
      build: () => genderCubit,
      act: (cubit) => cubit.saveGender(),
      expect: () => [
        isA<GenderError>(), // check error message if needed
      ],
    );

    blocTest<GenderCubit, GenderState>(
      'calls saveGenderUseCase and returns true when saveGender is called with selection',
      setUp: () {
        when(
          mockSaveGenderUseCase.executeWithParams(params: GenderValue.male),
        ).thenAnswer((_) async => true);
      },
      build: () => genderCubit,
      seed: () => const GenderSelected(GenderValue.male),
      act: (cubit) => cubit.saveGender(),
      expect: () => <GenderState>[], // No state emitted on success?
      verify: (_) {
        verify(
          mockSaveGenderUseCase.executeWithParams(params: GenderValue.male),
        ).called(1);
      },
    );

    blocTest<GenderCubit, GenderState>(
      'emits [GenderError] when saveGenderUseCase returns false',
      setUp: () {
        when(
          mockSaveGenderUseCase.executeWithParams(params: GenderValue.male),
        ).thenAnswer((_) async => false);
      },
      build: () => genderCubit,
      seed: () => const GenderSelected(GenderValue.male),
      act: (cubit) => cubit.saveGender(),
      expect: () => [isA<GenderError>()],
    );
  });
}
