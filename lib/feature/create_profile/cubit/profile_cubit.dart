import 'package:bodymetrics/core/extensions/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit_state.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFOrmCubitState> {
  UserInfoFormCubit() : super(const UserInfoFormCubitInitial(isFormEmpty: false));

  void setFormEmpty({required bool param}) {
    'param $param'.log;

    emit(
      UserInfoFormCubitInitial(
        isFormEmpty: param,
      ),
    );
  }
}
