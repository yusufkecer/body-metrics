import 'package:bodymetrics/core/index.dart';

extension DateExtension on String {
  String get toYMD {
    if (isNullOrEmpty) return '';
    final date = split('/');
    if (date.length < 3) return '';
    return '${date[2]}-${date[1]}-${date[0]}';
  }
}

extension RegexExtension on String {
  bool get isValidNumber => RegExp(r'^[0-9]*\.?[0-9]*$').hasMatch(this);
}
