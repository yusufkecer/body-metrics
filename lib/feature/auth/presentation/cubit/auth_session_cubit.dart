import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_session_state.dart';

@injectable
final class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._authService) : super(const AuthSessionLoading());

  final AuthService _authService;

  Future<void> loadSession() async {
    emit(const AuthSessionLoading());
    final isAuthenticated = await _authService.hasSession();
    if (isAuthenticated) {
      emit(const AuthSessionAuthenticated());
      return;
    }

    emit(const AuthSessionUnauthenticated());
  }

  Future<void> logout() async {
    await _authService.logoutLocal();
    emit(const AuthSessionUnauthenticated());
  }

  /// Returns true if account was successfully deleted (or was already gone).
  /// Returns false on network/server error — state is restored to authenticated.
  Future<bool> deleteAccount() async {
    emit(const AuthSessionDeleting());
    try {
      await _authService.deleteAccount();
      emit(const AuthSessionDeleted());
      return true;
    } on ApiException {
      // Non-401/404 error (already handled in service) — restore auth state
      emit(const AuthSessionAuthenticated());
      return false;
    } catch (e) {
      'AuthSessionCubit.deleteAccount unexpected error: $e'.e();
      emit(const AuthSessionAuthenticated());
      return false;
    }
  }
}
