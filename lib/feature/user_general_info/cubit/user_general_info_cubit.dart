part of 'user_general_info_state.dart';

sealed class UserInfoFOrmCubitState extends Equatable {
  const UserInfoFOrmCubitState({this.isFormEmpty});

  final bool? isFormEmpty;

  @override
  List<Object> get props => [isFormEmpty ?? false];
}

class UserInfoFormCubitInitial extends UserInfoFOrmCubitState {
  const UserInfoFormCubitInitial({super.isFormEmpty});
}
