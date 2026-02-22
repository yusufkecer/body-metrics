import 'package:bloc_test/bloc_test.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/presentation/cubit/weight_picker_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UserUseCase>(),
  MockSpec<SaveWeightUseCase>(),
  MockSpec<CalculateBmiUseCase>(),
])
import 'weight_picker_cubit_test.mocks.dart';

void main() {
  late MockUserUseCase mockUserUseCase;
  late MockSaveWeightUseCase mockSaveWeightUseCase;
  late MockCalculateBmiUseCase mockCalculateBmiUseCase;
  late WeightPickerCubit cubit;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
    mockSaveWeightUseCase = MockSaveWeightUseCase();
    mockCalculateBmiUseCase = MockCalculateBmiUseCase();
    AppUtil.currentUserId = 1;

    // Default stubs
    when(
      mockUserUseCase.getCurrentUser(),
    ).thenAnswer((_) async => const User(id: 1, height: 180));
    when(
      mockCalculateBmiUseCase.executeWithParams(params: anyNamed('params')),
    ).thenAnswer((_) async => 22.0);
  });

  tearDown(() {
    cubit.close();
  });

  group('WeightPickerCubit', () {
    test('initial state is WeightPickerInitial', () {
      cubit = WeightPickerCubit(
        mockUserUseCase,
        mockSaveWeightUseCase,
        mockCalculateBmiUseCase,
      );
      expect(cubit.state, isA<WeightPickerInitial>());
    });

    blocTest<WeightPickerCubit, WeightPickerState>(
      'getUser emits [WeightPickerInitial(user)] on success',
      build: () => WeightPickerCubit(
        mockUserUseCase,
        mockSaveWeightUseCase,
        mockCalculateBmiUseCase,
      ),
      // getUser is called in constructor
      expect: () => [
        isA<WeightPickerInitial>().having((s) => s.user?.id, 'user.id', 1),
      ],
    );

    blocTest<WeightPickerCubit, WeightPickerState>(
      'saveBodyMetrics emits error when user not found (id null)',
      setUp: () {
        AppUtil.currentUserId = null;
      },
      build: () => WeightPickerCubit(
        mockUserUseCase,
        mockSaveWeightUseCase,
        mockCalculateBmiUseCase,
      ),
      act: (cubit) => cubit.saveBodyMetrics(weight: 70),
      expect: () => [isA<WeightPickerInitial>(), isA<WeightPickerError>()],
      skip: 1,
    );

    blocTest<WeightPickerCubit, WeightPickerState>(
      'saveBodyMetrics success flow',
      setUp: () {
        when(
          mockSaveWeightUseCase.executeWithParams(params: anyNamed('params')),
        ).thenAnswer((_) async => true);
      },
      build: () => WeightPickerCubit(
        mockUserUseCase,
        mockSaveWeightUseCase,
        mockCalculateBmiUseCase,
      ),
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        await cubit.saveBodyMetrics(weight: 70);
      },
      expect: () => [
        isA<WeightPickerInitial>(),
        isA<WeightPickerLoading>(),
        isA<WeightPickerSuccess>(),
      ],
    );
  });
}
