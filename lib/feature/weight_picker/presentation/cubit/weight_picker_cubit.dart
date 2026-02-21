import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_metric_use_case.dart';
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
    this._userMetricUseCase,
  ) : super(const WeightPickerInitial()) {
    getUser();
  }

  final UserUseCaseImpl _userUseCase;
  final SaveWeightUseCase _saveWeightUseCase;
  final CalculateBmiUseCase _calculateBmiUseCase;
  final UserMetricUseCase _userMetricUseCase;

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

    return roundedBmi;
  }

  Future<double> _getLastWeight(int userId) async {
    try {
      final metrics = await _userMetricUseCase.executeWithParams(
        params: UserMetric(userId: userId),
      );
      final list = metrics?.userMetrics;
      if (list == null || list.isEmpty) return 0;
      return list.last.weight ?? 0;
    } catch (e) {
      'WeightPickerCubit _getLastWeight error: $e'.log();
      return 0;
    }
  }

  Future<bool> saveBodyMetrics({
    required double weight,
  }) async {
    final currentUser = state.user;
    emit(WeightPickerLoading(user: currentUser));

    final id = AppUtil.currentUserId;
    if (id == null) {
      emit(const WeightPickerError(error: LocaleKeys.exception_user_not_found));
      return false;
    }

    if (state.user.isNullOrEmpty) {
      await getUser();
    }

    final userHeight = state.user?.height;
    if (userHeight.isNullOrEmpty) {
      emit(const WeightPickerError(error: LocaleKeys.exception_height_not_saved));
      return false;
    }

    final bmi = await calculateBmi(weight);
    if (bmi == null) {
      emit(const WeightPickerError(error: LocaleKeys.exception_generic_error));
      return false;
    }

    final oldWeight = await _getLastWeight(id);
    final createdAt = DateTime.now();

    final metricsEntity = UserMetric(
      userId: id,
      height: userHeight,
      weight: weight,
      bmi: bmi,
      userMetric: _resolveBodyMetricResult(bmi),
      date: DateFormat('dd-MM-yyyy').format(createdAt),
      createdAt: createdAt.toIso8601String(),
      weightDiff: weight - oldWeight,
    );

    'Saving weight: $metricsEntity'.log();
    final result =
        await _saveWeightUseCase.executeWithParams(params: metricsEntity);

    if (!result) {
      emit(const WeightPickerError(error: LocaleKeys.exception_generic_error));
      return false;
    }

    emit(WeightPickerSuccess(user: state.user));
    return true;
  }

  BodyMetricResult _resolveBodyMetricResult(double bmi) {
    if (bmi < 18.5) return BodyMetricResult.underweight;
    if (bmi < 25) return BodyMetricResult.normal;
    if (bmi < 30) return BodyMetricResult.overweight;
    if (bmi < 40) return BodyMetricResult.obese;
    return BodyMetricResult.morbidlyObese;
  }
}
