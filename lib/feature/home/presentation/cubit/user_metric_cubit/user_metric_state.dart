


part of 'user_metric_cubit.dart';

sealed class UserMetricState extends Equatable {
  const UserMetricState();

  @override
  List<Object?> get props => [];
}

final class UserMetricInitial extends UserMetricState {
  const UserMetricInitial();
}

final class UserMetricLoading extends UserMetricState {
  const UserMetricLoading();
}

final class UserMetricSuccess extends UserMetricState {
  const UserMetricSuccess({required this.userMetric});

  final UserMetrics userMetric;

  @override
  List<Object?> get props => [userMetric];
}

final class UserMetricError extends UserMetricState {
  const UserMetricError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
