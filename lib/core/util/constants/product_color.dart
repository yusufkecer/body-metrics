import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  final Color _seedColor = Colors.deepPurple;
  final Color _seedFourTenths = Colors.deepPurple.withAlpha(102);

  final Color _pink = Colors.pink;
  final Color _blue = Colors.blue;

  final Color _bg1 = const Color(0xFF6A1B9A);
  final Color _bg2 = const Color(0xFF9747FF);
  final Color _drawerBg = Colors.deepPurple.withAlpha(128);
  final Color _drawerBg2 = Colors.deepPurple.withAlpha(51);

  final Color _white = Colors.white;
  final Color _whiteEightTenths = Colors.white.withAlpha(204);

  final Color _transparent = Colors.transparent;

  final List<Color> animatedColorList = [
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 133, 188, 233),
    const Color.fromARGB(255, 226, 218, 145),
    const Color.fromARGB(255, 211, 114, 107),
    const Color.fromARGB(255, 140, 238, 143),
  ];

  final List<Color> _backgroundColorList = [
    const Color(0xFF6A1B9A),
    const Color(0xFF9747FF),
  ];

  Color get seedColor => _seedColor;
  Color get pink => _pink;
  Color get blue => _blue;
  Color get seedFourTenths => _seedFourTenths;
  Color get deepPurple => _bg1;
  Color get lightPurple => _bg2;
  Color get drawerBg => _drawerBg;
  Color get drawerBg2 => _drawerBg2;
  Color get white => _white;
  Color get whiteEightTenths => _whiteEightTenths;
  Color get transparent => _transparent;

  List<Color> get backgroundColorList => _backgroundColorList;

  List<Color> get colorfulList => animatedColorList;
}
