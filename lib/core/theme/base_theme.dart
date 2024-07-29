import 'package:flutter/material.dart';
import 'package:myapp/core/theme/theme_constant.dart';
import 'package:myapp/product/constants/product_radius.dart';

abstract base class BaseTheme {
  Brightness get brightness;
  Iterable<ThemeExtension<ThemeExtension>> get extensions;

  ThemeData get theme {
    return ThemeData(
      fontFamily: 'Poppins',
      brightness: brightness,
      extensions: extensions,
      colorSchemeSeed: Colors.deepPurple,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      expansionTileTheme: _expansionTileThemeData,
      listTileTheme: _listTileThemeData,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
    );
  }

  final AppBarTheme _appBarTheme = const AppBarTheme(
    centerTitle: true,
  );

  final CardTheme _cardTheme = const CardTheme(
    margin: EdgeInsets.zero,
    elevation: ThemeConstants.elevation,
    shape: RoundedRectangleBorder(
      borderRadius: ProductRadius.ten(),
    ),
  );

  final DialogTheme _dialogTheme = const DialogTheme(
    elevation: ThemeConstants.elevation,
    shape: RoundedRectangleBorder(
      borderRadius: ProductRadius.ten(),
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

  final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ThemeConstants.elevation,
      minimumSize: const Size.fromHeight(kToolbarHeight),
      shape: const RoundedRectangleBorder(
        borderRadius: ProductRadius.ten(),
      ),
    ),
  );

  final InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: ProductRadius.ten()),
  );
}
