part of 'profile_cubit.dart';

sealed class UserInfoFOrmCubitState extends Equatable {
  final CreateProfileEntity createProfileEntity;
  const UserInfoFOrmCubitState({required this.createProfileEntity});

  @override
  List<Object> get props => [];
}

final class UserInfoFormCubitInitial extends UserInfoFOrmCubitState {
  const UserInfoFormCubitInitial({required super.createProfileEntity});
}
