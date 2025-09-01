import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_gender_state.dart';

@injectable
class GenderCubit extends Cubit<GenderState> {
  GenderCubit(this._saveGenderUseCase) : super(const GenderState());
  final SaveGenderUseCase _saveGenderUseCase;

  void changeGender(SelectGender newGender) {
    emit(SelectGender(genderValue: newGender.genderValue));
  }

  bool? setGender() {
    return state.genderValue.isNotNull;
  }

  Future<bool?> saveGender() async {
    '${state.genderValue}'.log();
    if (state.genderValue == null) {
      emit(const SelectGenderError(error: LocaleKeys.gender_gender_is_null));
      return null;
    }

    final result = await _saveGenderUseCase.executeWithParams(params: state.genderValue);
    return result;
  }
}
