part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

final class UserInitial extends UserState {
  const UserInitial({super.user});
}

final class UserLoading extends UserState {
  const UserLoading({super.user});
}
