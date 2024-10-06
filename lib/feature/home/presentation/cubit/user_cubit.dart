import 'package:bloc/bloc.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/data/cache/bmi_cache/user_metrics_columns.dart';
import 'package:bodymetrics/data/cache/user_cache/user_cache_columns.dart';
import 'package:bodymetrics/data/index.dart';
import 'package:bodymetrics/domain/index.dart';
import 'package:bodymetrics/feature/home/domain/use_case/user_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  Future<void> getUser() async {
    final useCase = Locator.sl<UserUseCase>();
    final userId = AppUtil.currentUserId;
    final filters = UserFilters(id: userId);

    final join = JoinEntity(
      currentKey: UserCacheColumns.id.value,
      joinKey: UserMetricsColumns.id.value,
      table: UserMetricsColumns.table.value,
      type: JoinType.inner.type,
    );

    final user = await useCase.executeWithParams(
      ParamsEntity(
        filters: filters.toJson(),
        joins: [join],
      ),
    );

    emit(UserInitial(user: user));
  }
}
