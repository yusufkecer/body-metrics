import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/index.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userUseCase) : super(const UserLoading()) {
    getUser();
  }

  final UserUseCase _userUseCase;

  Future<void> getUser() async {
    try {
      final userId = AppUtil.currentUserId;
      if (userId == null) {
        emit(const UserError(message: 'Current user ID not set'));
        return;
      }

      final filters = UserFilters(id: userId);

      final join = JoinEntity(
        currentKey: UserCacheColumns.id.value,
        joinKey: UserMetricsColumns.id.value,
        table: UserMetricsColumns.table.value,
        type: JoinType.inner.type,
      );

      final params = ParamsEntity(
        filters: filters.toJson(),
        joins: [join],
      );

      final user = await _userUseCase.executeWithParams(params: params);

      if (user == null) {
        emit(const UserError(message: 'User not found'));
        return;
      }

      final safeUser = user.copyWith(
        id: user.id,
        name: user.name ?? '',
        surname: user.surname ?? '',
        avatar: user.avatar ?? '',
        gender: user.gender,
        height: user.height,
        userMetrics: user.userMetrics,
        birthOfDate: user.birthOfDate,
      );

      emit(UserLoaded(user: safeUser));
    } catch (e, st) {
      'UserCubit error: $e\n$st'.log();
      emit(const UserError(message: 'An unexpected error occurred'));
    }
  }
}
