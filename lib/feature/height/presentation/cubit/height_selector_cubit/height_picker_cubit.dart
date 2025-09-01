part of '../../height_picker.dart';

@injectable
class HeightSelectorCubit extends Cubit<HeightSelectorState> {
  HeightSelectorCubit() : super(const HeightSelectorInitial());

  void updateHeight(double page, int minValue, int maxValue) {
    var currentPosition = 0;
    var currentHeight = 0.0;
    final position = page.floor() + minValue + 1;

    if (position != currentPosition && position <= maxValue) {
      currentPosition = position;
      currentHeight = _calculateHeight(position);

      emit(HeightSelectorInitial(page: currentPosition, height: currentHeight));
    }
  }

  double _calculateHeight(int position,
      {int minValue = 65, int maxValue = 252}) {
    return ((position * 2) * (maxValue - minValue)) / 233;
  }

}
