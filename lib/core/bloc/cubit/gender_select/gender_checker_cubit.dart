import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gender_checker_state.dart';

class GenderCheckerCubit extends Cubit<GenderCheckerState> {
  GenderCheckerCubit() : super(GenderCheckerInitial());
}
