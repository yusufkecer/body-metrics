part of '../user_info_form.dart';

class UserInfoFormEntity extends Equatable {
  final bool isFormEmpty;

  const UserInfoFormEntity({
    this.isFormEmpty = false,
  });

  UserInfoFormEntity copyWith({
    bool? isFormEmpty,
  }) {
    return UserInfoFormEntity(
      isFormEmpty: isFormEmpty ?? this.isFormEmpty,
    );
  }

  @override
  List<Object?> get props => [isFormEmpty];
}
