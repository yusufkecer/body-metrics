import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/weight_picker/domain/entity/bmi_value.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/calculate_bmi_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
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

    final heightCm = state.user?.height;

    if (weight.isNullOrEmpty || heightCm.isNullOrEmpty) return null;

    final heightM = heightCm! / 100;
    final bmiValue = BmiValue(weight: weight, height: heightM);
    final bmi = await _calculateBmiUseCase.executeWithParams(params: bmiValue);
    final roundedBmi = double.parse(bmi.toStringAsFixed(2));

    emit(WeightPickerSuccess(user: state.user));
    return roundedBmi;
  }

  Future<bool> saveBodyMetrics({
    required double weight,
    double oldWeight = 0,
  }) async {
    final id = AppUtil.currentUserId;
    if (id == null) return false;

    final bmi = await calculateBmi(weight);
    'bmi: $bmi'.log();

    final metricsEntity = UserMetric(
      userId: id,
      weight: weight,
      bmi: bmi,
      date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      weightDiff: weight - oldWeight,
    ).toJson();

    final userMetricEntity = UserMetric.fromJson(metricsEntity);
    'Saving weight: $userMetricEntity'.log();
    final result =
        await _saveWeightUseCase.executeWithParams(params: userMetricEntity);

    return result;
  }
}
