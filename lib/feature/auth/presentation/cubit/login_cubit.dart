import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
final class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authService, this._syncLocalDataUseCase)
      : super(const LoginInitial());

  final AuthService _authService;
  final SyncLocalDataUseCase _syncLocalDataUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());
    try {
      await _authService.login(email: email, password: password);
      await _syncLocalDataUseCase.execute();
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginError('$e'));
    }
  }
}
