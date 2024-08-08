// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "calculator": "BMI Calculator",
  "cont": "Continue",
  "gender": {
    "gender": "Gender",
    "female": "Female",
    "male": "Erkek"
  }
};
static const Map<String,dynamic> tr = {
  "calculator": "VKİ Hesapla",
  "cont": "Devam",
  "gender": {
    "gender": "Cinsiyet",
    "female": "Kadın",
    "male": "Erkek"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "tr": tr};
}
