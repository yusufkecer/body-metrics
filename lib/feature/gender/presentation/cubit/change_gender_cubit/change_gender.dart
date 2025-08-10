import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_gender_state.dart';

@injectable
class GenderCubit extends Cubit<GenderState> {
  GenderCubit(this.saveGenderUseCase) : super(const GenderState());
  final SaveGenderUseCase saveGenderUseCase;

  void changeGender(SelectGender newGender) {
    emit(SelectGender(genderValue: newGender.genderValue));
  }

  bool? setGender() {
    return state.genderValue.isNotNull;
  }

  Future<bool?> saveGender() async {
    '${state.genderValue}'.log();

    final result = await saveGenderUseCase.executeWithParams(state.genderValue!);
    return result;
  }
}
