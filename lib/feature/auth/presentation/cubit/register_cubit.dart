import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
final class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authService, this._syncLocalDataUseCase)
    : super(const RegisterInitial());

  final AuthService _authService;
  final SyncLocalDataUseCase _syncLocalDataUseCase;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    try {
      await _authService.register(email: email, password: password);
      if (AppUtil.currentUserId != null) {
        await _syncLocalDataUseCase.execute();
      }
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterError('$e'));
    }
  }
}
