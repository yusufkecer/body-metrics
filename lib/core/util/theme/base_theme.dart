import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
final class BaseTheme {
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
      scaffoldBackgroundColor: ProductColor().transparent,
      checkboxTheme: _checkboxTheme,
      dialogBackgroundColor: ProductColor().seedColor,
      datePickerTheme: _datePickerTheme,
      textSelectionTheme: _textSelectionTheme,
      colorScheme: ColorScheme.dark(
        primary: ProductColor().seedColor,
        surface: ProductColor().seedColor,
        surfaceBright: ProductColor().white,
      ),
    );
  }

  final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: ProductColor().deepPurple,
    centerTitle: true,
    elevation: ThemeConstants.elevationZero,
    surfaceTintColor: ProductColor().transparent,
  );

  final TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
    cursorColor: ProductColor().white,
    selectionColor: ProductColor().seedColor,
    selectionHandleColor: ProductColor().seedColor,
  );

  final CardTheme _cardTheme = const CardTheme(
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
  final DialogTheme _dialogTheme = DialogTheme(
    barrierColor: ProductColor().seedFourTenths,
    elevation: 2,
    shadowColor: ProductColor().white,
    shape: const RoundedRectangleBorder(
      borderRadius: ProductRadius.fifteen(),
    ),
  );

  final ExpansionTileThemeData _expansionTileThemeData = const ExpansionTileThemeData(
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
    side: BorderSide(color: ProductColor().white),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor().white;
      }
      return ProductColor().transparent;
    }),
    checkColor: WidgetStateProperty.all(ProductColor().seedColor),
  );

  final DatePickerThemeData _datePickerTheme = DatePickerThemeData(
    backgroundColor: ProductColor().seedColor,
    dividerColor: ProductColor().white,
    dayForegroundColor: WidgetStateProperty.all(ProductColor().white),
    yearForegroundColor: WidgetStateProperty.all(ProductColor().white),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor().seedColor;
      }
      return ProductColor().transparent;
    }),
    yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ProductColor().seedColor;
      }
      return ProductColor().transparent;
    }),
    yearOverlayColor: WidgetStateProperty.all(ProductColor().white),
    headerForegroundColor: ProductColor().white,
    cancelButtonStyle: ThemeConstants.datePickerButton,
    shadowColor: ProductColor().white,
    elevation: ThemeConstants.elevation,
    surfaceTintColor: ProductColor().white,
    confirmButtonStyle: ThemeConstants.datePickerButton,
  );

  final ButtonStyle _onboardButton = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.pressed) ? ProductColor().seedColor : ProductColor().white,
    ),
  );

  ButtonStyle get onboardButton => _onboardButton;
}
