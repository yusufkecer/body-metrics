import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lotties';
  static const String image = 'assets/images';
  static const String language = 'assets/language';
  static const String gif = 'assets/gif';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this.json';
  String get image => '${AssetPath.image}/$this.png';
  String get language => '${AssetPath.language}/$this.json';
}

enum AssetValue {
  male('male'),
  female('female');

  final String value;

  const AssetValue(this.value);
}
