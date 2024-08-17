import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}

// extension CloseKeyboard on BuildContext {
//   FocusNode get focusScope => FocusScope.of(this);
//   void get unfocus => focusScope.unfocus();
// }
