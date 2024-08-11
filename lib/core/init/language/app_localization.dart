import 'package:bmicalculator/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@immutable
@lazySingleton
final class ProductLocalization extends EasyLocalization {
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          startLocale: Lang.tr.locale,
          supportedLocales: _supportedItems,
          path: AssetPath.language,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedItems = [
    Lang.tr.locale,
    Lang.en.locale,
  ];

  Future<void> updateLanguage({
    required BuildContext context,
    required Lang value,
  }) =>
      context.setLocale(value.locale);
}
