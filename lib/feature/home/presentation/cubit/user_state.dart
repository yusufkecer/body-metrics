part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  UserState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

final class UserInitial extends UserState {
  UserInitial({super.user});
}
