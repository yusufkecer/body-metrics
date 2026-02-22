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
}
