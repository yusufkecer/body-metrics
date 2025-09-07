import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_metric_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part  'user_metric_state.dart';

@injectable
class UserMetricCubit extends Cubit<UserMetricState> {
  UserMetricCubit(this._userMetricUseCase) : super(const UserMetricInitial());

  final UserMetricUseCase _userMetricUseCase;

  Future<void> getUserMetric(int userId) async {
    try {
      emit(const UserMetricLoading());

      final params = UserMetric(id: userId);
      final result = await _userMetricUseCase.executeWithParams(params: params);

      if (result != null) {
        emit(UserMetricSuccess(userMetric: result));
      } else {
        emit(const UserMetricError(error: 'User metric not found'));
      }
    } catch (e) {
      'UserMetricCubit getUserMetric error: $e'.log();
      emit(UserMetricError(error: e.toString()));
    }
  }
}
