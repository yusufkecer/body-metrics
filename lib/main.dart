import 'package:bmicalculator/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    EasyLocalization(
      supportedLocales: [Locale(Lang.en.name), Locale(Lang.tr.name)],
      fallbackLocale: Locale(Lang.tr.name),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      path: AssetPath.language,
      child: const BMICalculator(),
    ),
  );
  await InitApp.init();
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BMI Calculator',
      theme: Locator.instance.get<BaseTheme>().theme,
      routerConfig: Locator.instance.get<AppRouter>().config(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'),
      // ],
    );
  }
}
