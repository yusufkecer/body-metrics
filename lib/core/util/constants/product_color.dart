import 'package:flutter/material.dart';

@immutable
final class ProductColor {
  ProductColor._init();

  static final ProductColor _instance = ProductColor._init();

  static ProductColor get instance => _instance;

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

  final Color _whiteAlpha0 = Colors.white.withAlpha(0);
  final Color _whiteAlpha20 = Colors.white.withAlpha(20);
  final Color _whiteAlpha28 = Colors.white.withAlpha(28);
  final Color _whiteAlpha40 = Colors.white.withAlpha(40);
  final Color _whiteAlpha50 = Colors.white.withAlpha(50);
  final Color _whiteAlpha70 = Colors.white.withAlpha(70);
  final Color _whiteAlpha80 = Colors.white.withAlpha(80);
  final Color _whiteAlpha130 = Colors.white.withAlpha(130);
  final Color _whiteAlpha160 = Colors.white.withAlpha(160);
  final Color _whiteAlpha200 = Colors.white.withAlpha(200);
  final Color _whiteAlpha235 = Colors.white.withAlpha(235);

  final Color _blackAlpha40 = Colors.black.withAlpha(40);
  final Color _blackAlpha50 = Colors.black.withAlpha(50);
  final Color _blackAlpha65 = Colors.black.withAlpha(65);

  final Color _warning = const Color(0xFFFFD54F);

  final Color _transparent = Colors.transparent;

  final Color _teal = const Color(0xFF00BCD4);
  final Color _cardBg = const Color(0x33673AB7);
  final Color _chartGradientStart = const Color(0xFF00E5FF);
  final Color _chartGradientEnd = const Color(0xFF9C27B0);
  final Color _cardBorder = const Color(0x1AFFFFFF);
  final Color _subtleGrid = const Color(0x14FFFFFF);

  final Color _bmiUnderweight = const Color(0xFF42A5F5);
  final Color _bmiNormal = const Color(0xFF66BB6A);
  final Color _bmiOverweight = const Color(0xFFFFA726);
  final Color _bmiObese = const Color(0xFFEF5350);
  final Color _bmiMorbidlyObese = const Color(0xFFD32F2F);

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
  Color get whiteAlpha0 => _whiteAlpha0;
  Color get whiteAlpha20 => _whiteAlpha20;
  Color get whiteAlpha28 => _whiteAlpha28;
  Color get whiteAlpha40 => _whiteAlpha40;
  Color get whiteAlpha50 => _whiteAlpha50;
  Color get whiteAlpha70 => _whiteAlpha70;
  Color get whiteAlpha80 => _whiteAlpha80;
  Color get whiteAlpha130 => _whiteAlpha130;
  Color get whiteAlpha160 => _whiteAlpha160;
  Color get whiteAlpha200 => _whiteAlpha200;
  Color get whiteAlpha235 => _whiteAlpha235;

  Color get blackAlpha40 => _blackAlpha40;
  Color get blackAlpha50 => _blackAlpha50;
  Color get blackAlpha65 => _blackAlpha65;

  Color get warning => _warning;

  Color get transparent => _transparent;
  Color get teal => _teal;
  Color get cardBg => _cardBg;
  Color get chartGradientStart => _chartGradientStart;
  Color get chartGradientEnd => _chartGradientEnd;
  Color get cardBorder => _cardBorder;
  Color get subtleGrid => _subtleGrid;
  Color get bmiUnderweight => _bmiUnderweight;
  Color get bmiNormal => _bmiNormal;
  Color get bmiOverweight => _bmiOverweight;
  Color get bmiObese => _bmiObese;
  Color get bmiMorbidlyObese => _bmiMorbidlyObese;

  List<Color> get backgroundColorList => _backgroundColorList;

  List<Color> get colorfulList => animatedColorList;
}
