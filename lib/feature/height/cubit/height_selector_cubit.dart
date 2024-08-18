part of '../height.dart';

@injectable
class HeightSelectorCubit extends Cubit<HeightSelectorState> {
  HeightSelectorCubit()
      : super(
          HeightSelectorInitial(
            _initPage.toInt(),
            _initPage,
          ),
        );

  final int _maxValue = 252;
  final int _minValue = 65;
  static const double _initPage = 165;
  int currentPosition = 0;
  double currentHeight = 0;

  void updateHeight(double page) {
    final position = page.floor() + _minValue + 1;

    if (position != currentPosition && position <= _maxValue) {
      currentPosition = position;
      currentHeight = _calculateHeight(position);
    }

    emit(HeightSelectorInitial(currentPosition, currentHeight));
  }

  double _calculateHeight(int position) {
    return ((position * 2) * (_maxValue - _minValue)) / 233;
  }
}
