import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lotties';
  static const String image = 'assets/images';
  static const String profile = 'assets/images/profiles';
  static const String language = 'assets/language';
  static const String gif = 'assets/gif';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this.json';
  String get image => '${AssetPath.image}/$this';
  String get profile => '${AssetPath.profile}/$this';
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
  profile6('pr6.png'),
  ;

  final String value;

  const AssetValue(this.value);
}

extension AssetList on List<AssetValue> {
  List<String> get profileImageList {
    return [
      AssetValue.profile1.value,
      AssetValue.profile2.value,
      AssetValue.profile3.value,
      AssetValue.profile4.value,
      AssetValue.profile5.value,
      AssetValue.profile6.value,
    ];
  }
}
