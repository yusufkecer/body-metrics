import 'package:bodymetrics/core/extensions/string_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtension', () {
    test('toYMD should convert dd/mm/yyyy to yyyy-mm-dd', () {
      expect('01/02/2023'.toYMD, '2023-02-01');
    });

    test('toYMD should return empty string if input is null or empty', () {
      expect(''.toYMD, '');
    });

    test('toYMD should return empty string if format is invalid (less than 3 parts)', () {
      expect('01/02'.toYMD, '');
    });

    test('isValidNumber should return true for valid number string', () {
      expect('123'.isValidNumber, true);
      expect('123.45'.isValidNumber, true);
      expect('.45'.isValidNumber, true);
    });

    test('isValidNumber should return false for invalid number string', () {
      expect('abc'.isValidNumber, false);
      expect('12.34.56'.isValidNumber, false);
    });
  });
}
