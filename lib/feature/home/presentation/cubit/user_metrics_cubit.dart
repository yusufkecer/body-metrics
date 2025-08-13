import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_metrics_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_metrics_state.dart';

@injectable
class UserMetricsCubit extends Cubit<UserMetricsState> {
  UserMetricsCubit(this._userMetricsUseCase) : super(const UserMetricsInitial());
  final UserMetricsUseCase _userMetricsUseCase;

  Future<void> getUserMetrics() async {
    emit(const UserMetricsLoading());
    
    try {
      final userId = AppUtil.currentUserId;
      final filters = {'user_id': userId};
      final paramsEntity = ParamsEntity(filters: filters);
      
      final userMetrics = await _userMetricsUseCase.executeWithParams(paramsEntity);
      
      if (userMetrics != null && userMetrics.userMetrics?.isNotEmpty == true) {
        emit(UserMetricsLoaded(userMetrics: userMetrics));
      } else {
        emit(const UserMetricsEmpty());
      }
    } catch (e) {
      emit(UserMetricsError(message: e.toString()));
    }
  }

  Future<void> getAllMetrics() async {
    emit(const UserMetricsLoading());
    
    try {
      final userMetrics = await _userMetricsUseCase.execute();
      
      if (userMetrics != null && userMetrics.userMetrics?.isNotEmpty == true) {
        emit(UserMetricsLoaded(userMetrics: userMetrics));
      } else {
        emit(const UserMetricsEmpty());
      }
    } catch (e) {
      emit(UserMetricsError(message: e.toString()));
    }
  }
}