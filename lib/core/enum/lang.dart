import 'package:bodymetrics/core/util/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

enum Lang {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US'));

  final Locale locale;
  // ignore: sort_constructors_first
  const Lang(this.locale);

  String get flag => switch (this) {
    Lang.tr => '${AssetPath.countries}/tr.png',
    Lang.en => '${AssetPath.countries}/uk.png',
  };

  String get displayName => switch (this) {
    Lang.tr => 'Türkçe',
    Lang.en => 'English',
  };
}
