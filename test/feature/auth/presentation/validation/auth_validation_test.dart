import 'package:bodymetrics/feature/auth/presentation/validation/auth_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthValidation', () {
    test('isValidEmail returns true for valid email', () {
      expect(AuthValidation.isValidEmail('test@example.com'), true);
    });

    test('isValidEmail returns false for invalid email and empty value', () {
      expect(AuthValidation.isValidEmail('invalid-email'), false);
      expect(AuthValidation.isValidEmail(''), false);
      expect(AuthValidation.isValidEmail(null), false);
    });

    test('isValidForgotPasswordToken validates 6-char token', () {
      expect(AuthValidation.isValidForgotPasswordToken('123456'), true);
      expect(AuthValidation.isValidForgotPasswordToken('12345'), false);
      expect(AuthValidation.isValidForgotPasswordToken('1234567'), false);
    });

    test('isValidPassword validates minimum length', () {
      expect(AuthValidation.isValidPassword('123456'), true);
      expect(AuthValidation.isValidPassword('12345'), false);
      expect(AuthValidation.isValidPassword(null), false);
    });

    test('isPasswordConfirmationValid matches trimmed values', () {
      expect(AuthValidation.isPasswordConfirmationValid('abc123', 'abc123'), true);
      expect(
        AuthValidation.isPasswordConfirmationValid(' abc123 ', 'abc123'),
        true,
      );
      expect(AuthValidation.isPasswordConfirmationValid('abc123', 'abc124'), false);
    });
  });
}
