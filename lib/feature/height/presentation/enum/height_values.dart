part of '../height_picker.dart';

enum _HeightValues {
  minValue(65),
  maxValue(252);

  final int value;

  // ignore: sort_constructors_first
  const _HeightValues(this.value);
}

enum _PickerValues {
  currentValue(165),
  viewportFraction(0.15);

  final double value;

  // ignore: sort_constructors_first
  const _PickerValues(this.value);
}
