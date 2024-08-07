import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  final Color _seedColor = Colors.deepPurple;
  final Color _pink = Colors.pink;
  final Color _blue = Colors.blue;
  final Color _backgroundColor = const Color(0xFF3A3047);

  Color get seedColor => _seedColor;
  Color get pink => _pink;
  Color get blue => _blue;
  Color get backgroundColor => _backgroundColor;
}
