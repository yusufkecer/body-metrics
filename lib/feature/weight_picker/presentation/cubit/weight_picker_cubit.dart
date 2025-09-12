import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/weight_picker/domain/entity/bmi_value.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'weight_picker_state.dart';

@injectable
final class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit(
    this._userUseCase,
    this._saveWeightUseCase,
    this._calculateBmiUseCase,
  ) : super(const WeightPickerInitial()) {
    getUser();
  }

  final UserUseCaseImpl _userUseCase;
  final SaveWeightUseCase _saveWeightUseCase;
  final CalculateBmiUseCase _calculateBmiUseCase;

  Future<void> getUser() async {
    try {
      final user = await _userUseCase.getCurrentUser();
      emit(WeightPickerInitial(user: user));
    } catch (e) {
      'WeightPickerCubit getUser error: $e'.log();
      emit(const WeightPickerInitial());
    }
  }

  Future<double?> calculateBmi(double weight) async {
    if (state.user.isNullOrEmpty) {
      await getUser();
    }

    if (state.user.isNullOrEmpty) return null;

    final height = state.user?.height;

    if (weight.isNullOrEmpty || height.isNullOrEmpty) return null;

    final bmiValue = BmiValue(weight: weight, height: height!);
    final bmi = await _calculateBmiUseCase.executeWithParams(params: bmiValue);

    emit(WeightPickerSuccess(user: state.user));
    return bmi;
  }

  Future<bool> saveBodyMetrics(double weight) async {
    final id = AppUtil.currentUserId;
    if (id == null) return false;

    final bmi = await calculateBmi(weight);

    final metricsEntity = UserMetric(
      userId: id,
      weight: weight,
      bmi: bmi,
    ).toJson();

    final userMetricEntity = UserMetric.fromJson(metricsEntity);
    'Saving weight: $userMetricEntity'.log();
    final result =
        await _saveWeightUseCase.executeWithParams(params: userMetricEntity);

    return result;
  }
}
