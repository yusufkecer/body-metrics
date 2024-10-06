import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/entities/user_metric_entity.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart';
import 'package:bodymetrics/feature/weight_picker/domain/use_case/save_weight_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'weight_picker_state.dart';

@injectable
class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit() : super(const WeightPickerInitial());

  Future<void> getUser() async {
    final userCase = Locator.sl<UserUseCase>();
    final userId = AppUtil.currentUserId;
    "userId $userId".log;
    final filters = UserFilters(id: userId);

    final paramsEntity = ParamsEntity(filters: filters.toJson());

    final user = await userCase.executeWithParams(paramsEntity);

    "user $user".log;

    emit(WeightPickerInitial(user: user, isLoading: false));
  }

  Future<void> calculateBmi(double weight) async {
    if (state.user.isNullOrEmpty) {
      await compute(
        (message) {
          getUser();
        },
        'Fetching  user date',
      );
    }

    if (state.user.isNullOrEmpty) return;

    final user = state.user;

    final height = user?.height;

    if (weight.isNullOrEmpty || height.isNullOrEmpty) return;

    var bmi = 0.0;

    await compute((message) {
      bmi = _calculateBmiValue(weight, height!);
    }, 'Calculating BMI');

    emit(WeightPickerInitial(user: user, bmi: bmi));
  }

  double _calculateBmiValue(double weight, double height) {
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

    final userMetric = Locator.sl<SaveWeightUseCase>();

    final result = await userMetric.executeWithParams(userMetricEntity);

    return result;
  }
}
