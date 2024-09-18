import 'package:bodymetrics/core/index.dart';
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

  bool? saveGender() {
    if (state.genderValue.isNotNull) {
      return true;
    }
    return false;
  }
}
