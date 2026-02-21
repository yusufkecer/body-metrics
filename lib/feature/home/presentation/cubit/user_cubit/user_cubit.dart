import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userUseCase) : super(const UserLoading()) {
    getUserAndHistory();
  }

  final UserUseCaseImpl _userUseCase;

  Future<void> getUserAndHistory() async {
    try {
      final user = await _userUseCase.getCurrentUser();

      if (user == null) {
        emit(const UserError(message: LocaleKeys.exception_user_not_found));
        return;
      }

      final safeUser = user.copyWith(
        id: user.id,
        name: user.name ?? '',
        surname: user.surname ?? '',
        avatar: user.avatar ?? '',
        gender: user.gender,
        height: user.height,
        birthOfDate: user.birthOfDate,
      );

      emit(UserLoaded(user: safeUser));
    } catch (e, st) {
      'UserCubit error: $e\n$st'.log();
      emit(const UserError(message: LocaleKeys.exception_generic_error));
    }
  }
}
