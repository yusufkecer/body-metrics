import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lotties';
  static const String image = 'assets/images';
  static const String profile = 'assets/images';
  static const String language = 'assets/language';
  static const String gif = 'assets/gif';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this.json';
  String get image => '${AssetPath.image}/$this';
  String get profile => '${AssetPath.image}/$this';
  String get language => '${AssetPath.language}/$this.json';
}

enum AssetValue {
  male('male'),
  female('female'),
  maleBody('male_body'),
  femaleBody('female_body'),
  profile1('pr1.png'),
  profile2('pr2.png'),
  profile3('pr3.png'),
  profile4('pr4.png'),
  profile5('pr5.png'),
  ;

  final String value;

  const AssetValue(this.value);
}
