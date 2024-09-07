import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'user_general_info_cubit.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFOrmCubitState> {
  UserInfoFormCubit() : super(const UserInfoFormCubitInitial(isFormEmpty: true));

  void setFormEmpty({required bool param}) {
    emit(UserInfoFormCubitInitial(isFormEmpty: param));
  }
}
