import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_gender_state.dart';

@injectable
class GenderCubit extends Cubit<GenderState> {
  GenderCubit(this._saveGenderUseCase) : super(const GenderInitial());

  final SaveGenderUseCase _saveGenderUseCase;

  void selectGender(GenderValue gender) {
    if (state is GenderSelected && (state as GenderSelected).genderValue == gender) {
      emit(const GenderInitial());
    } else {
      emit(GenderSelected(gender));
    }
  }

  Future<bool> saveGender() async {
    if (state is! GenderSelected) {
      emit(const GenderError(LocaleKeys.gender_gender_is_null));
      return false;
    }

    final gender = (state as GenderSelected).genderValue;
    final result = await _saveGenderUseCase.executeWithParams(params: gender);

    if (result == false) {
      emit(GenderError(LocaleKeys.dialog_general_error, genderValue: gender));
    }

    return result ?? false;
  }
}
