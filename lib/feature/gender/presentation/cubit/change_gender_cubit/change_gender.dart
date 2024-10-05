import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/feature/gender/domain/use_case/save_gender_use_case.dart';
import 'package:bodymetrics/injection/locator.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_gender_state.dart';

@injectable
class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(const GenderState());

  void changeGender(SelectGender newGender) {
    emit(SelectGender(genderValue: newGender.genderValue));
  }

  bool? setGender() {
    if (state.genderValue.isNotNull) {
      return true;
    }
    return false;
  }

  Future<bool?> saveGender() async {
    final model = Locator.sl<SaveGenderUseCase>();
    final result = await model.executeWithParams(state.genderValue!);
    return result;
  }
}
