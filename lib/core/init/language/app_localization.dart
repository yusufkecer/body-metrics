import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class AppLocalization extends EasyLocalization {
  AppLocalization({
    required super.child,
    super.key,
  }) : super(
          startLocale: _startLocale,
          supportedLocales: _supportedItems,
          path: AssetPath.language,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedItems = [
    Lang.tr.locale,
    Lang.en.locale,
    Lang.de.locale,
  ];
  static Locale get _startLocale {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    return Lang.fromLocale(systemLocale).locale;
  }

  Future<void> updateLanguage({
    required BuildContext context,
    required Lang value,
  }) =>
      context.setLocale(value.locale);
}
