import 'package:bodymetrics/core/regex/product_regex.dart';

final class AuthValidation {
  const AuthValidation._();

  static bool isValidEmail(String? value) {
    final emailValue = value?.trim() ?? '';
    if (emailValue.isEmpty) return false;
    return ProductRegex.email.hasMatch(emailValue);
  }

  static bool isValidForgotPasswordToken(String? value) {
    final token = value?.trim() ?? '';
    return token.length == 6;
  }

  static bool isValidPassword(String? value, {int minLength = 6}) {
    final password = value?.trim() ?? '';
    return password.length >= minLength;
  }

  static bool isPasswordConfirmationValid(
    String? confirmPassword,
    String? password,
  ) {
    return (confirmPassword?.trim() ?? '') == (password?.trim() ?? '');
  }
}
