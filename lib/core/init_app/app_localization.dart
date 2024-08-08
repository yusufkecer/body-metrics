import 'package:bmicalculator/core/enum/lang.dart';
import 'package:bmicalculator/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductLocalization extends EasyLocalization {
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          assetLoader: const CodegenLoader(),
          supportedLocales: _supportedItems,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedItems = [
    Lang.tr.locale,
    Lang.en.locale,
  ];

  static const String _translationPath = 'assets/language';

  static Future<void> updateLanguage({
    required BuildContext context,
    required Lang value,
  }) =>
      context.setLocale(value.locale);
}
