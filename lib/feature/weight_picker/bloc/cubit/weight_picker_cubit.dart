import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weight_picker_state.dart';

class WeightPickerCubit extends Cubit<WeightPickerState> {
  WeightPickerCubit() : super(WeightPickerInitial());
}
