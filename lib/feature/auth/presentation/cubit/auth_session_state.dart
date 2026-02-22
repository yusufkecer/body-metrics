part of 'auth_session_cubit.dart';

sealed class AuthSessionState {
  const AuthSessionState();
}

final class AuthSessionLoading extends AuthSessionState {
  const AuthSessionLoading();
}

final class AuthSessionAuthenticated extends AuthSessionState {
  const AuthSessionAuthenticated();
}

final class AuthSessionUnauthenticated extends AuthSessionState {
  const AuthSessionUnauthenticated();
}
