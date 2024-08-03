import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lottie';
  static const String image = 'assets/images';
  static const String language = 'assets/language';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this';
  String get image => '${AssetPath.image}/$this';
}
