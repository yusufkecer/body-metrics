import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'weight_picker_state.dart';

@injectable
class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit() : super(const WeightPickerInitial());

  Future<void> _getUser() async {
    final userCase = Locator.sl<UserUseCase>();
    final userId = AppUtil.currentUserId;

    final filters = UserFilters(id: userId);

    final paramsEntity = ParamsEntity(filters: filters.toJson());

    final user = await userCase.executeWithParams(paramsEntity);

    emit(WeightPickerInitial(user: user));
  }

  Future<void> calculateBmi(double weight) async {
    await compute(
      (message) {
        _getUser();
      },
      'Fetching  user date',
    );

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

  Future<void> saveBodyMetrics(double weight) async {
    await _getUser();

    if (state.user.isNullOrEmpty) return;

    final id = AppUtil.currentUserId;

    final userFilters = UserFilters(id: id);

    final paramsEntity = ParamsEntity(filters: userFilters.toJson());

    final userCase = Locator.sl<UserUseCase>();

    emit(WeightPickerInitial(user: updatedUser));
  }
}
