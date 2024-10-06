part of 'weight_picker_cubit.dart';

sealed class WeightPickerState extends Equatable {
  const WeightPickerState({this.weight, this.bmi, this.user});

  final int? weight;
  final double? bmi;
  final User? user;

  @override
  List<Object> get props => [weight ?? 0, bmi ?? 0.0, user ?? const User()];
}

final class WeightPickerInitial extends WeightPickerState {
  const WeightPickerInitial({super.weight, super.bmi, super.user});
}
