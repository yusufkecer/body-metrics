import 'package:bodymetrics/core/index.dart';

extension DateExtension on String {
  static const Map<String, String> _arabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  static const Map<String, String> _normalizedDigits = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
    '٫': '.',
    '٬': '',
  };

  String get normalizedDigits {
    var value = this;
    for (final entry in _normalizedDigits.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }

  String get toArabicDigits {
    var value = this;
    for (final entry in _arabicDigits.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value.replaceAll('.', '٫');
  }

  String get toYMD {
    if (isNullOrEmpty) return '';
    final date = normalizedDigits.split('/');
    if (date.length < 3) return '';
    return '${date[2]}-${date[1]}-${date[0]}';
  }
}

extension RegexExtension on String {
  bool get isValidNumber =>
      RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(normalizedDigits);
}
