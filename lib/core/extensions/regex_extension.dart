extension RegexExtension on String {
  bool get formNotEmpty => RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ0-9]+$').hasMatch(this);
  bool get min3Char => RegExp(r'^.{2,}$').hasMatch(this);
  bool get isValidDate => RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(this);

  bool get checkForm => formNotEmpty && min3Char;
  bool get checkDateForm => isValidDate;
}
