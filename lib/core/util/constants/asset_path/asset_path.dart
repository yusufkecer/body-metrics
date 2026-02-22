import 'package:flutter/material.dart';

@immutable
abstract final class AssetPath {
  static const String lottie = 'assets/lotties';
  static const String image = 'assets/images';
  static const String language = 'assets/language';
  static const String gif = 'assets/gif';
  static const String countries = 'assets/countries';
}

extension AssetPathExtension on String {
  String get lottie => '${AssetPath.lottie}/$this.json';
  String get image => '${AssetPath.image}/$this';
  String get profile => '${AssetPath.image}/profiles/$this';
  String get onboard => '${AssetPath.image}/onboard/$this';
  String get language => '${AssetPath.language}/$this.json';
}

enum AssetValue {
  male('male'),
  female('female'),
  maleBody('male_body'),
  femaleBody('female_body'),
  robotError('robot_error'),
  success('success'),
  generalError('general_error'),
  loading('loading'),
  confirm('confirm'),
  profile1('pr1.png'),
  profile2('pr2.png'),
  profile3('pr3.png'),
  profile4('pr4.png'),
  profile5('pr5.png'),
  profile6('pr6.png'),
  ob1('ob1.png'),
  ob2('ob2.png'),
  ob3('ob3.png'),
  ob4('ob4.png'),
  ob5('ob5.png'),
  ;

  final String value;

  // ignore: sort_constructors_first
  const AssetValue(this.value);
}

extension AssetList on List<AssetValue> {
  List<String> get profileImageList {
    return [
      AssetValue.profile1.value.profile,
      AssetValue.profile2.value.profile,
      AssetValue.profile3.value.profile,
      AssetValue.profile4.value.profile,
      AssetValue.profile5.value.profile,
      AssetValue.profile6.value.profile,
    ];
  }
}
