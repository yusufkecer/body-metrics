import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<BuildContext> pumpLocalized(WidgetTester tester, Locale locale) async {
    late BuildContext localizedContext;

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: [locale],
          path: 'assets/language',
          startLocale: locale,
          saveLocale: false,
          useOnlyLangCode: true,
          child: Builder(
            builder: (context) {
              localizedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();

    return localizedContext;
  }

  testWidgets('formatDecimal uses Arabic-Indic digits in Arabic', (
    tester,
  ) async {
    final context = await pumpLocalized(tester, const Locale('ar'));

    expect(
      context.formatDecimal(23.45, fractionDigits: 2, useGrouping: false),
      '٢٣٫٤٥',
    );
    expect(context.formatSignedDecimal(-1.5), '-١٫٥');
  });

  testWidgets('formatDecimal keeps Latin digits in English', (tester) async {
    final context = await pumpLocalized(tester, const Locale('en'));

    expect(
      context.formatDecimal(23.45, fractionDigits: 2, useGrouping: false),
      '23.45',
    );
    expect(context.formatSignedDecimal(-1.5), '-1.5');
  });
}
