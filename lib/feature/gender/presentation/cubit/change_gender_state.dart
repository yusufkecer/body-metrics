part of 'change_gender.dart';

class GenderState extends Equatable {
  final GenderValue? genderValue;
  const GenderState({this.genderValue});
  @override
  List<Object> get props => [genderValue ?? ''];
}

final class SelectGender extends GenderState {
  const SelectGender({super.genderValue});
}
