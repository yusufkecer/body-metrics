part of 'gender.dart';

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

    setState(() {});
  }
}
