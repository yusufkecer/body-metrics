import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lottie';
  static const String image = 'assets/images';
  static const String language = 'assets/language';
  static const String gif = 'assets/gif';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this';
  String get image => '${AssetPath.image}/$this';
  String get language => '${AssetPath.language}/$this';
  String get gif => '${AssetPath.gif}/$this';
}

enum AssetValue {
  womenGif('women.gif'),
  manGif('man.gif');

  final String value;

  const AssetValue(this.value);
}
