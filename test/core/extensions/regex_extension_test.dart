import 'package:bodymetrics/core/extensions/regex_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegexExtension', () {
    test('formNotEmpty should return true for alphanumeric and Turkish characters', () {
      expect('abc123ğüşıöç'.formNotEmpty, true);
    });

    test('formNotEmpty should return false for special characters or spaces', () {
      expect('abc 123'.formNotEmpty, false);
      expect('abc!'.formNotEmpty, false);
    });

    test('min3Char should return true for string with 2 or more characters', () {
      // Based on regex ^.{2,}$
      expect('ab'.min3Char, true);
      expect('abc'.min3Char, true);
    });

    test('min3Char should return false for string with less than 2 characters', () {
      expect('a'.min3Char, false);
      expect(''.min3Char, false);
    });

    test('isValidDate should return true for valid date format dd/mm/yyyy', () {
      expect('01/01/2023'.isValidDate, true);
    });

    test('isValidDate should return false for invalid date format', () {
      expect('2023/01/01'.isValidDate, false);
      expect('01-01-2023'.isValidDate, false);
      expect('1/1/2023'.isValidDate, false); // Regex expects 2 digits
    });
    
    test('checkForm should return true if formNotEmpty and min3Char are true', () {
      expect('abc'.checkForm, true);
    });

     test('checkForm should return false if formNotEmpty is false', () {
      expect('ab!'.checkForm, false);
    });

     test('checkForm should return false if min3Char is false', () {
      expect('a'.checkForm, false);
    });

     test('checkDateForm should return true if isValidDate is true', () {
      expect('01/01/2023'.checkDateForm, true);
    });
  });
}
