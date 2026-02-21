part of 'weight_picker_cubit.dart';

sealed class WeightPickerState extends Equatable {
  const WeightPickerState({this.user});

  final User? user;

  @override
  List<Object> get props => [user ?? const User()];
}

final class WeightPickerInitial extends WeightPickerState {
  const WeightPickerInitial({super.user});
}

final class WeightPickerLoading extends WeightPickerState {
  const WeightPickerLoading({super.user});
}

final class WeightPickerError extends WeightPickerState {
  const WeightPickerError({required this.error, super.user});

  final String error;

  @override
  List<Object> get props => [...super.props, error];
}

final class WeightPickerSuccess extends WeightPickerState {
  const WeightPickerSuccess({super.user});
}
