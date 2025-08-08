import 'package:flutter/material.dart';

abstract interface class BaseTheme {
  late AppBarTheme _appBarTheme;
  late CardThemeData _cardTheme;
  late TextSelectionThemeData _textSelectionTheme;
  late ChipThemeData _chipTheme;
  late DialogThemeData _dialogTheme;
  late ExpansionTileThemeData _expansionTileThemeData;
  late ListTileThemeData _listTileThemeData;
  late FilledButtonThemeData _filledButtonTheme;
  late InputDecorationTheme _inputDecorationTheme;
  late CheckboxThemeData _checkboxTheme;
  late DatePickerThemeData _datePickerTheme;
  late ButtonStyle _onboardButton;

  AppBarTheme get appBarTheme => _appBarTheme;
  CardThemeData get cardTheme => _cardTheme;
  TextSelectionThemeData get textSelectionTheme => _textSelectionTheme;
  ChipThemeData get chipTheme => _chipTheme;
  DialogThemeData get dialogTheme => _dialogTheme;
  ExpansionTileThemeData get expansionTileThemeData => _expansionTileThemeData;
  ListTileThemeData get listTileThemeData => _listTileThemeData;
  FilledButtonThemeData get filledButtonTheme => _filledButtonTheme;
  InputDecorationTheme get inputDecorationTheme => _inputDecorationTheme;
  CheckboxThemeData get checkboxTheme => _checkboxTheme;
  DatePickerThemeData get datePickerTheme => _datePickerTheme;
  ButtonStyle get onboardButton => _onboardButton;
}
