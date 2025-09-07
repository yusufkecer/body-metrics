import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'height_picker_state.dart';

@injectable
final class HeightSelectorCubit extends Cubit<HeightSelectorState> {
  HeightSelectorCubit() : super(const HeightSelectorUpdateHeight());

  void updateHeight(double page, int minValue, int maxValue) {
    var currentPosition = 0;
    var currentHeight = 0.0;
    final position = page.floor() + minValue + 1;

    if (position != currentPosition && position <= maxValue) {
      currentPosition = position;
      currentHeight = _calculateHeight(position);

      emit(HeightSelectorUpdateHeight(userHeight: currentPosition, height: currentHeight));
    }
  }

  double _calculateHeight(
    int position, {
    int minValue = 65,
    int maxValue = 252,
  }) {
    return ((position * 2) * (maxValue - minValue)) / 233;
  }
}
