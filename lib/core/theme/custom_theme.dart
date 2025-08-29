import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
class CustomTheme implements BaseTheme {
  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      dialogTheme: _dialogTheme,
      expansionTileTheme: _expansionTileThemeData,
      listTileTheme: _listTileThemeData,
      filledButtonTheme: _filledButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ProductColor.instance.transparent,
      checkboxTheme: _checkboxTheme,
      datePickerTheme: _datePickerTheme,
      textSelectionTheme: _textSelectionTheme,
      colorScheme: ColorScheme.dark(
        primary: ProductColor.instance.seedColor,
        surface: ProductColor.instance.seedColor,
        surfaceBright: ProductColor.instance.white,
      ),
    );
  }

  final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: ProductColor.instance.deepPurple,
    centerTitle: true,
    elevation: ThemeConstants.elevationZero,
    surfaceTintColor: ProductColor.instance.transparent,
  );

  final TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
    cursorColor: ProductColor.instance.white,
    selectionColor: ProductColor.instance.seedColor,
    selectionHandleColor: ProductColor.instance.seedColor,
  );

  final CardThemeData _cardTheme = const CardThemeData(
    elevation: ThemeConstants.elevation,
    shape: RoundedRectangleBorder(
      borderRadius: ProductRadius.fifteen(),
    ),
  );
  final ChipThemeData _chipTheme = const ChipThemeData(
    elevation: ThemeConstants.elevation,
    shape: RoundedRectangleBorder(
      borderRadius: ProductRadius.fifteen(),
    ),
  );
  final DialogThemeData _dialogTheme = DialogThemeData(
    barrierColor: ProductColor.instance.seedFourTenths,
    backgroundColor: ProductColor.instance.seedColor,
    elevation: 2,
    shadowColor: ProductColor.instance.white,
    shape: const RoundedRectangleBorder(
      borderRadius: ProductRadius.fifteen(),
    ),
  );

  final ExpansionTileThemeData _expansionTileThemeData =
      const ExpansionTileThemeData(
    tilePadding: EdgeInsets.zero,
    shape: Border(),
  );

  final ListTileThemeData _listTileThemeData = const ListTileThemeData(
    contentPadding: EdgeInsets.zero,
  );

  final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ThemeConstants.elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: ProductRadius.ten(),
      ),
    ),
  );

  final InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: ProductRadius.ten()),
  );

  final CheckboxThemeData _checkboxTheme = CheckboxThemeData(
    side: BorderSide(color: ProductColor.instance.white),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor.instance.white;
      }
      return ProductColor.instance.transparent;
    }),
    checkColor: WidgetStateProperty.all(ProductColor.instance.seedColor),
  );

  final DatePickerThemeData _datePickerTheme = DatePickerThemeData(
    backgroundColor: ProductColor.instance.seedColor,
    dividerColor: ProductColor.instance.white,
    dayForegroundColor: WidgetStateProperty.all(ProductColor.instance.white),
    yearForegroundColor: WidgetStateProperty.all(ProductColor.instance.white),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor.instance.seedColor;
      }
      return ProductColor.instance.transparent;
    }),
    yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor.instance.seedColor;
      }
      return ProductColor.instance.transparent;
    }),
    yearOverlayColor: WidgetStateProperty.all(ProductColor.instance.white),
    headerForegroundColor: ProductColor.instance.white,
    cancelButtonStyle: ThemeConstants.datePickerButton,
    shadowColor: ProductColor.instance.white,
    elevation: ThemeConstants.elevation,
    surfaceTintColor: ProductColor.instance.white,
    confirmButtonStyle: ThemeConstants.datePickerButton,
  );

  final ButtonStyle _onboardButton = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.pressed)
          ? ProductColor.instance.seedColor
          : ProductColor.instance.white,
    ),
  );

  @override
  AppBarTheme get appBarTheme => _appBarTheme;

  @override
  CardThemeData get cardTheme => _cardTheme;

  @override
  CheckboxThemeData get checkboxTheme => _checkboxTheme;

  @override
  ChipThemeData get chipTheme => _chipTheme;

  @override
  DatePickerThemeData get datePickerTheme => _datePickerTheme;

  @override
  DialogThemeData get dialogTheme => _dialogTheme;

  @override
  ExpansionTileThemeData get expansionTileThemeData => _expansionTileThemeData;

  @override
  FilledButtonThemeData get filledButtonTheme => _filledButtonTheme;

  @override
  InputDecorationTheme get inputDecorationTheme => _inputDecorationTheme;

  @override
  ListTileThemeData get listTileThemeData => _listTileThemeData;

  @override
  ButtonStyle get onboardButton => _onboardButton;

  @override
  TextSelectionThemeData get textSelectionTheme => _textSelectionTheme;
}
