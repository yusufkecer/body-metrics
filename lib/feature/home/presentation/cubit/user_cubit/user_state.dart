part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  const UserLoaded({required this.user});
  final User user;

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  const UserError({this.message = 'Error'});
  final String message;
  @override
  List<Object?> get props => [message];
}
