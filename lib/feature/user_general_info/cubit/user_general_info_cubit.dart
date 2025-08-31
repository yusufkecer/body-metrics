import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/user_general_info/domain/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'user_general_info_state.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFormCubitState> {
  UserInfoFormCubit(this._createProfileUseCase)
      : super(const UserInfoFormCubitFormEmpty(isFormEmpty: true));

  final CreateProfileUseCase _createProfileUseCase;

  void setFormEmpty({required bool param}) {
    emit(UserInfoFormCubitFormEmpty(isFormEmpty: param));
  }

  Future<bool?> createProfile(User user) async {
    emit(const UserInfoFormCubitLoading());
    final result = await _createProfileUseCase.executeWithParams(user);
    emit(const UserInfoFormCubitSuccess());
    return result;
  }
}
