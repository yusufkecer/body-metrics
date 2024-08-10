import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  final Color _seedColor = Colors.deepPurple;
  final Color _pink = Colors.pink;
  final Color _blue = Colors.blue;

  final Color _bg1 = const Color(0xFF6A1B9A);
  final Color _bg2 = const Color(0xFF9747FF);
  final Color _white = Colors.white;

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

  Color get deepPurple => _bg1;
  Color get lightPurple => _bg2;
  List<Color> get colorfulList => animatedColorList;
  Color get white => _white;
}
