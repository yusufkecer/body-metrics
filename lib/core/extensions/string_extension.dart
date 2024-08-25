import 'package:bodymetrics/core/index.dart';

extension DateExtension on String {
  String get toYMD {
    if (isEmpty || isNull) return '';
    final date = split('/');
    if (date.length < 3) return '';
    return '${date[2]}-${date[1]}-${date[0]}';
  }
}
