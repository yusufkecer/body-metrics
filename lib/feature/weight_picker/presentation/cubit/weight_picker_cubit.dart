import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'weight_picker_state.dart';

@injectable
class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit(this._userUseCase, this._saveWeightUseCase) : super(const WeightPickerInitial());
  final UserUseCase _userUseCase;
  final SaveWeightUseCase _saveWeightUseCase;

  Future<void> getUser() async {
    final userId = AppUtil.currentUserId;
    final filters = UserFilters(id: userId);

    final paramsEntity = ParamsEntity(filters: filters.toJson());

    final user = await _userUseCase.executeWithParams(paramsEntity);

    emit(WeightPickerInitial(user: user, isLoading: false));
  }

  Future<void> calculateBmi(double weight) async {
    if (state.user.isNullOrEmpty) {
      await getUser();
    }

    if (state.user.isNullOrEmpty) return;

    final user = state.user;

    final height = user?.height;

    if (weight.isNullOrEmpty || height.isNullOrEmpty) return;

    final bmi = await compute(_calculateBmiValue, {'weight': weight, 'height': height});

    emit(WeightPickerInitial(user: user, bmi: bmi));
  }

  double _calculateBmiValue(Map<String, double?> data) {
    final weight = data['weight']!;
    final height = data['height']!;
    final bmi = weight / (height * height);

    return bmi;
  }

  Future<bool> saveBodyMetrics(double weight, double bmi) async {
    if (state.user.isNullOrEmpty) {
      await getUser();
    }

    final id = AppUtil.currentUserId;

    final metricsEntity = UserMetric(
      id: id,
      weight: weight,
      bmi: bmi,
    ).toJson();

    final userMetricEntity = UserMetricEntity(data: metricsEntity);

    final result = await _saveWeightUseCase.executeWithParams(userMetricEntity);

    return result;
  }
}
