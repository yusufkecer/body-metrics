part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

final class ForgotPasswordCodeSent extends ForgotPasswordState {
  const ForgotPasswordCodeSent();
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
}

final class ForgotPasswordError extends ForgotPasswordState {
  const ForgotPasswordError(this.message);

  final String message;
}
