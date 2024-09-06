import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit_state.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFOrmCubitState> {
  UserInfoFormCubit() : super(UserInfoFormCubitInitial());

  void setFormEmpty({required bool param}) {
    emit(
      UserInfoFormCubitInitial(
        isFormEmpty: param,
      ),
    );
  }
}
