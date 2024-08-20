part of '../weight_picker.dart';

extension DecimalAdjustment on String {
  int converter() {
    if (!contains('.')) return 0;
    final splitValue = split('.');
    if (splitValue.isEmpty || splitValue.length <= 1) return 0;

    final decimalValue = splitValue[1];
    final integerValue = splitValue[0];

    final integer = int.parse(integerValue);
    final decimalFirst = int.parse(decimalValue[0]);
    final decimalSecond = int.parse(decimalValue[1]);

    if (decimalSecond >= 5) {
      if (decimalFirst == 9) {
        return integer + 1;
      }
      return decimalFirst + 1;
    } else {
      return decimalFirst;
    }
  }

  int get convert => converter();
}
