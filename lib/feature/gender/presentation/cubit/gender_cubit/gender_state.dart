part of 'gender_cubit.dart';

sealed class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object?> get props => [];
}

class GenderInitial extends GenderState {
  const GenderInitial();
}

class GenderSelected extends GenderState {
  const GenderSelected(this.genderValue);

  final GenderValue genderValue;

  @override
  List<Object?> get props => [genderValue];
}

class GenderError extends GenderState {
  const GenderError(this.error, {this.genderValue});

  final String error;
  final GenderValue? genderValue;

  @override
  List<Object?> get props => [error, genderValue];
}
