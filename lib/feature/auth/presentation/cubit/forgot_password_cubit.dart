import 'package:bodymetrics/data/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_state.dart';

@injectable
final class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authService) : super(const ForgotPasswordInitial());

  final AuthService _authService;

  Future<void> sendCode(String email) async {
    emit(const ForgotPasswordLoading());
    try {
      await _authService.forgotPassword(email: email);
      emit(const ForgotPasswordCodeSent());
    } catch (e) {
      emit(ForgotPasswordError('$e'));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    emit(const ForgotPasswordLoading());
    try {
      await _authService.resetPassword(
        email: email,
        token: token,
        password: password,
      );
      emit(const ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError('$e'));
    }
  }
}
