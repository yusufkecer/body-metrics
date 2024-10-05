part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState({required this.isLoading, this.user});

  UserState copyWith({
    User? user,
    bool isLoading,
  });

  final bool isLoading;
  final User? user;

  @override
  List<Object?> get props => [user, isLoading];
}

final class UserInitial extends UserState {
  const UserInitial({super.user, super.isLoading = true});

  @override
  UserState copyWith({User? user, bool? isLoading}) {
    return UserInitial(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
