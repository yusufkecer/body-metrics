import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  final Color _seedColor = Colors.deepPurple;
  final Color _pink = Colors.pink;
  final Color _blue = Colors.blue;
  final Color _backgroundColor = const Color(0xFF3A3047);
  final Color _darkPurple = Color.fromARGB(255, 75, 60, 167);
  final Color _lightPurple = const Color(0xFF9747FF);

  final List<Color> animatedColorList = [
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 133, 188, 233),
    const Color.fromARGB(255, 226, 218, 145),
    const Color.fromARGB(255, 211, 114, 107),
    const Color.fromARGB(255, 140, 238, 143),
  ];

  Color get seedColor => _seedColor;
  Color get pink => _pink;
  Color get blue => _blue;
  Color get backgroundColor => _backgroundColor;
  Color get deepPurple => _darkPurple;
  Color get lightPurple => _lightPurple;
  List<Color> get colorfulList => animatedColorList;
}
