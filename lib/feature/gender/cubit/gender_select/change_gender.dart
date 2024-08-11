import 'package:bmicalculator/core/index.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_gender_state.dart';

@injectable
class GenderCubit extends Cubit<GenderState> {
  GenderCubit({GenderValue? genderValue})
      : _genderValue = genderValue,
        super(SelectGender(genderValue: genderValue));

  GenderValue? _genderValue;

  GenderValue get genderValue => _genderValue!;

  void changeGender({GenderValue? newGender}) {
    _genderValue = newGender;
    emit(SelectGender(genderValue: _genderValue));
  }
}
