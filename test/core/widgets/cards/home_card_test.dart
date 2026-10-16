import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpHomeCard(
    WidgetTester tester, {
    required String title,
    required bool showButton,
  }) async {
    tester.view
      ..physicalSize = const Size(360, 800)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final controller = AnimationController(vsync: const TestVSync(), value: 1);
    addTearDown(controller.dispose);

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('ar')],
          path: 'assets/language',
          startLocale: const Locale('ar'),
          saveLocale: false,
          useOnlyLangCode: true,
          child: Builder(
            builder: (context) => MaterialApp(
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: HomeCard(
                    onPressed: () {},
                    title: title,
                    icon: Icons.show_chart,
                    buttonTitle: LocaleKeys.home_see_more,
                    showButton: showButton,
                    animationController: controller,
                    children: const [],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();
  }

  testWidgets('chart card title fits in Arabic', (tester) async {
    await pumpHomeCard(
      tester,
      title: LocaleKeys.home_line_chart,
      showButton: false,
    );

    expect(find.text('مخطط مؤشر كتلة الجسم'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('card title with button fits in Arabic', (tester) async {
    await pumpHomeCard(tester, title: LocaleKeys.home_report, showButton: true);

    expect(find.text('التقرير'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
