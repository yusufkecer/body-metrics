extension RegexExtension on String {
  //string number

  bool get isValidNumber => RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(this);
}
