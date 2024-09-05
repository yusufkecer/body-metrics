import 'package:bodymetrics/feature/create_profile/domain/entity/create_profile_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit_state.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFOrmCubitState> {
  UserInfoFormCubit(CreateProfileEntity profileEntity)
      : super(UserInfoFormCubitInitial(createProfileEntity: profileEntity));

  void setFormEmpty({required bool isFormEmpty}) {
    emit(
      UserInfoFormCubitInitial(
        createProfileEntity: state.createProfileEntity.copyWith(isFormEmpty: isFormEmpty),
      ),
    );
  }
}
