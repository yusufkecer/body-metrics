import 'package:bodymetrics/core/extensions/string_extension.dart';

extension RegexExtension on String {
  bool get formNotEmpty =>
      RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ\u0600-\u06FF0-9]+$').hasMatch(this);
  bool get min3Char => RegExp(r'^.{2,}$').hasMatch(this);
  bool get isValidDate =>
      RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(normalizedDigits);

  bool get checkForm => formNotEmpty && min3Char;
  bool get checkDateForm => isValidDate;
}
