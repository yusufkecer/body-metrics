import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  final Color _seedColor = Colors.deepPurple;
  final Color _accentColor = Colors.deepPurpleAccent;

  Color get seedColor => _seedColor;
  Color get accentColor => _accentColor;
}
