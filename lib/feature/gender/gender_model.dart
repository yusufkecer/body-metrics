part of 'gender.dart';

// ignore: library_private_types_in_public_api
mixin GenderModel on State<Gender> {
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
    print('isMale: $isMale');
    print('isFemale: $isFemale');
    // var genderValue = GenderValue.female;

    // if (this.isMale ?? false) {
    //   genderValue = GenderValue.female;
    // } else if (this.isFemale ?? false) {
    //   genderValue = GenderValue.male;
    // }

    setState(() {});
    // Locator.sl<GenderCubit>().changeGender(newGender: genderValue);
  }
}
