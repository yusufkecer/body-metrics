extension RegexExtension on String {
  bool get formNotEmpty => RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ0-9]+$').hasMatch(this);
  bool get min3Char => RegExp(r'^.{3,}$').hasMatch(this);

  bool get checkForm => formNotEmpty && min3Char;
}
