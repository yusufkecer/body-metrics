part of 'user_general_info_cubit.dart';

sealed class UserInfoFormCubitState extends Equatable {
  const UserInfoFormCubitState({this.isFormEmpty});

  final bool? isFormEmpty;

  @override
  List<Object> get props => [isFormEmpty ?? false];
}

class UserInfoFormCubitInitial extends UserInfoFormCubitState {
  const UserInfoFormCubitInitial();
}

class UserInfoFormCubitFormEmpty extends UserInfoFormCubitState {
  const UserInfoFormCubitFormEmpty({super.isFormEmpty});
}

class UserInfoFormCubitLoading extends UserInfoFormCubitState {
  const UserInfoFormCubitLoading();
}

class UserInfoFormCubitSuccess extends UserInfoFormCubitState {
  const UserInfoFormCubitSuccess();
}
class UserInfoFormCubitError extends UserInfoFormCubitState {
  const UserInfoFormCubitError();
}
