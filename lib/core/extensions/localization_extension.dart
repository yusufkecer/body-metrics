import 'package:bodymetrics/core/extensions/string_extension.dart';
import 'package:bodymetrics/core/init/language/locale_keys.g.dart';
import 'package:bodymetrics/core/util/app_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension LocalizationContextExtension on BuildContext {
  Locale get appLocale => locale;
  String get localeCode => appLocale.languageCode;
  bool get isArabicLocale => localeCode == 'ar';

  String get localizedAppName => AppUtil.appName;
  String get localizedBmiLabel => LocaleKeys.home_bmi.tr();
  String get localizedWeightUnit => LocaleKeys.weight_kg.tr();
  String get localizedHeightUnit => LocaleKeys.height_cm.tr();

  String localizeDigits(String value) {
    return isArabicLocale ? value.toArabicDigits : value;
  }

  String formatDecimal(
    num value, {
    int fractionDigits = 0,
    bool useGrouping = true,
  }) {
    final formatter = NumberFormat.decimalPattern(localeCode)
      ..minimumFractionDigits = fractionDigits
      ..maximumFractionDigits = fractionDigits;

    if (!useGrouping) {
      formatter.turnOffGrouping();
    }

    return formatter.format(value);
  }

  String formatSignedDecimal(num? value, {int fractionDigits = 1}) {
    if (value == null || value == 0) return '-';

    final sign = value.isNegative ? '-' : '+';
    return '$sign${formatDecimal(value.abs(), fractionDigits: fractionDigits, useGrouping: false)}';
  }

  String formatWeight(num? value, {int fractionDigits = 1}) {
    if (value == null) return '-';
    return '${formatDecimal(value, fractionDigits: fractionDigits, useGrouping: false)} $localizedWeightUnit';
  }

  String formatHeight(num value) {
    return '${formatDecimal(value, useGrouping: false)} $localizedHeightUnit';
  }

  String formatDate(
    DateTime date, {
    String pattern = 'dd/MM/yyyy',
  }) {
    return DateFormat(pattern, localeCode).format(date);
  }

  String formatIsoDate(
    String? raw, {
    String pattern = 'dd/MM/yyyy',
    String fallback = '',
  }) {
    if (raw == null || raw.isEmpty) return fallback;

    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return fallback;

    return formatDate(parsed, pattern: pattern);
  }

  String formatPatternDate(
    String? raw, {
    required String inputPattern,
    required String outputPattern,
    String fallback = '',
  }) {
    if (raw == null || raw.isEmpty) return fallback;

    try {
      final parsed = DateFormat(inputPattern).parseStrict(raw.normalizedDigits);
      return formatDate(parsed, pattern: outputPattern);
    } catch (_) {
      return localizeDigits(raw);
    }
  }
}
