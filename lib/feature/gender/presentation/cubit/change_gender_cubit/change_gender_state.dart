part of 'change_gender.dart';

class GenderState extends Equatable {
  const GenderState({this.genderValue});

  final GenderValue? genderValue;

  @override
  List<Object> get props => [genderValue ?? ''];
}

final class SelectGender extends GenderState {
  const SelectGender({super.genderValue});
}
