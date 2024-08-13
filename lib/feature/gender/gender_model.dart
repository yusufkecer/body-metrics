part of 'gender.dart';

// ignore: library_private_types_in_public_api
mixin GenderModel on State<_GenderView> {
  bool? isMale;
  bool? isFemale;
  void onChange({bool? value, bool isMale = false, bool isFemale = false}) {
    if (value == null) return;

    if (isMale) {
      this.isMale = (this.isMale ?? false) ? null : value;
      this.isFemale = (this.isMale == null) ? null : !value;
    } else if (isFemale) {
      this.isFemale = (this.isFemale ?? false) ? null : value;
      this.isMale = (this.isFemale == null) ? null : !value;
    }

    if (this.isMale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.male));
    } else if (this.isFemale ?? false) {
      context.read<GenderCubit>().changeGender(const SelectGender(genderValue: GenderValue.female));
    } else {
      context.read<GenderCubit>().changeGender(const SelectGender());
    }
  }
}
