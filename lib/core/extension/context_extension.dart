import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension MediaQueryExtension on BuildContext {
  Size get sizeOf => MediaQuery.sizeOf(this);
  double get width => sizeOf.width;
  double get height => sizeOf.height;
}

// extension CloseKeyboard on BuildContext {
//   FocusNode get focusScope => FocusScope.of(this);
//   void get unfocus => focusScope.unfocus();
// }
