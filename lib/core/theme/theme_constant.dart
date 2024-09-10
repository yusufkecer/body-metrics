import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ThemeConstants {
  const ThemeConstants._();
  static const elevationZero = 0.0;
  static const elevation = 2.0;
  static const homeCardSize = 0.38;

  static final ButtonStyle datePickerButton = TextButton.styleFrom(
    foregroundColor: ProductColor().white,
  );
}
