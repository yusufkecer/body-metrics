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
  const WeightPickerLoading();
}

final class WeightPickerError extends WeightPickerState {
  const WeightPickerError({required this.error});

  final String error;
}

final class WeightPickerSuccess extends WeightPickerState {
  const WeightPickerSuccess({super.user});
}
