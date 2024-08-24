import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ThemeConstants {
  static const elevationZero = 0.0;
  static const elevation = 2.0;

  static final ButtonStyle datePickerButton = TextButton.styleFrom(
    foregroundColor: ProductColor().white,
  );
}
