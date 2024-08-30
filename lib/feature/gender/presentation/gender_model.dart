part of 'gender.dart';

// ignore: library_private_types_in_public_api
mixin _GenderModel on State<_GenderView> {
  bool? _isMale;
  bool? _isFemale;
  void onChange({bool? value, bool isMale = false, bool isFemale = false}) {
    if (value == null) return;

    if (isMale) {
      _isMale = (_isMale ?? false) ? null : value;
      _isFemale = (_isMale == null) ? null : !value;
    } else if (isFemale) {
      _isFemale = (_isFemale ?? false) ? null : value;
      _isMale = (_isFemale == null) ? null : !value;
    }

    if (_isMale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.male));
    } else if (_isFemale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.female));
    } else {
      context.read<GenderCubit>().changeGender(const SelectGender());
    }
  }

  bool isSelected() => _isMale != null || _isFemale != null;
}
