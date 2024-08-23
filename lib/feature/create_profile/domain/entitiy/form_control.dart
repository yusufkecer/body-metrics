part of '../../create_profile.dart';

class FormControl extends Equatable {
  final bool isFormEmpty;

  const FormControl({
    this.isFormEmpty = false,
  });

  FormControl copyWith({
    bool? isFormEmpty,
  }) {
    return FormControl(
      isFormEmpty: isFormEmpty ?? this.isFormEmpty,
    );
  }

  @override
  List<Object?> get props => [isFormEmpty];
}
