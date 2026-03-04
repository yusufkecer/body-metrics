import 'package:bodymetrics/core/util/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

enum Lang {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US')),
  de(Locale('de', 'DE'));

  final Locale locale;
  // ignore: sort_constructors_first
  const Lang(this.locale);

  String get code => switch (this) {
    Lang.tr => 'TR',
    Lang.en => 'EN',
    Lang.de => 'DE',
  };

  String get displayName => switch (this) {
    Lang.tr => 'Türkçe',
    Lang.en => 'English',
    Lang.de => 'Deutsch',
  };

  String get flag => switch (this) {
    Lang.tr => AssetValue.countryTr.value.country,
    Lang.en => AssetValue.countryUk.value.country,
    Lang.de => AssetValue.countryDe.value.country,
  };

  static Lang fromLocale(Locale locale) {
    return Lang.values.firstWhere(
      (lang) => lang.locale.languageCode == locale.languageCode,
      orElse: () => Lang.tr,
    );
  }
}
