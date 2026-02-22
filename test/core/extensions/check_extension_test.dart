import 'package:bodymetrics/core/extensions/check_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CheckExtension', () {
    test('isNullOrEmpty should return true for null', () {
      const String? value = null;
      expect(value.isNullOrEmpty, true);
    });

    test('isNullOrEmpty should return true for empty string', () {
      const value = '';
      expect(value.isNullOrEmpty, true);
    });

    test('isNullOrEmpty should return true for empty list', () {
      final value = <dynamic>[];
      expect(value.isNullOrEmpty, true);
    });

    test('isNullOrEmpty should return false for non-empty string', () {
      const value = 'hello';
      expect(value.isNullOrEmpty, false);
    });

    test('isNullOrEmpty should return false for non-empty list', () {
      final value = [1, 2];
      expect(value.isNullOrEmpty, false);
    });

    test('isNotNull should return true for non-null value', () {
      const value = 'hello';
      expect(value.isNotNull, true);
    });

    test('isNotNull should return false for null value', () {
      const String? value = null;
      expect(value.isNotNull, false);
    });

    test('isNull should return true for null value', () {
      const String? value = null;
      expect(value.isNull, true);
    });

    test('isNull should return false for non-null value', () {
      const value = 'test';
      expect(value.isNull, false);
    });
  });

  group('TinyInt Extension', () {
    test('convertBoolResult should return true for positive integer', () {
      const value = 1;
      expect(value.convertBoolResult, true);
    });

    test(
      'convertBoolResult should return false for zero or negative integer',
      () {
        const value = 0;
        expect(value.convertBoolResult, false);
      },
    );
  });
}
