part of '../height_picker.dart';

@injectable
class HeightSelectorCubit extends Cubit<HeightSelectorState> {
  HeightSelectorCubit()
      : super(
          HeightSelectorInitial(
            _initPage.toInt(),
            _initPage,
          ),
        );

  static const double _initPage = 165;

  int _currentPosition = 0;
  double _currentHeight = 0;

  void updateHeight(double page, int minValue, int maxValue) {
    final position = page.floor() + minValue + 1;

    if (position != _currentPosition && position <= maxValue) {
      _currentPosition = position;
      _currentHeight = _calculateHeight(position);

      emit(HeightSelectorInitial(_currentPosition, _currentHeight));
    }
  }

  double _calculateHeight(int position, {int minValue = 65, int maxValue = 252}) {
    return ((position * 2) * (maxValue - minValue)) / 233;
  }
}
