part of 'profile_cubit.dart';

sealed class UserInfoFOrmCubitState extends Equatable {
  final bool? isFormEmpty;

  const UserInfoFOrmCubitState({this.isFormEmpty});

  @override
  List<Object> get props => [];
}

class UserInfoFormCubitInitial extends UserInfoFOrmCubitState {
  const UserInfoFormCubitInitial({super.isFormEmpty});
}
