part of 'user_metrics_cubit.dart';

abstract class UserMetricsState extends Equatable {
  const UserMetricsState();

  @override
  List<Object?> get props => [];
}

class UserMetricsInitial extends UserMetricsState {
  const UserMetricsInitial();
}

class UserMetricsLoading extends UserMetricsState {
  const UserMetricsLoading();
}

class UserMetricsLoaded extends UserMetricsState {
  const UserMetricsLoaded({required this.userMetrics});

  final UserMetrics userMetrics;

  @override
  List<Object?> get props => [userMetrics];
}

class UserMetricsEmpty extends UserMetricsState {
  const UserMetricsEmpty();
}

class UserMetricsError extends UserMetricsState {
  const UserMetricsError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}