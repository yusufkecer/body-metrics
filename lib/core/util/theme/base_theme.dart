import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@immutable
final class BaseTheme {
  ThemeData get theme {
    return ThemeData(
      colorSchemeSeed: ProductColor().seedColor,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      expansionTileTheme: _expansionTileThemeData,
      listTileTheme: _listTileThemeData,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent,
      checkboxTheme: _checkboxTheme,
    );
  }

  final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: ProductColor().deepPurple,
    centerTitle: true,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
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

  final ExpansionTileThemeData _expansionTileThemeData = const ExpansionTileThemeData(
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

  final CheckboxThemeData _checkboxTheme = const CheckboxThemeData(
    side: BorderSide(color: Colors.white),
  );
}
