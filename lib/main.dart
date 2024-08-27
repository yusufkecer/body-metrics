import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/injection/locator.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await InitApp.init();
  runApp(
    ProductLocalization(
      child: const Bodymetrics(),
    ),
  );
}

class Bodymetrics extends StatelessWidget {
  const Bodymetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BodyMetrics',
      theme: Locator.sl<BaseTheme>().theme,
      routerConfig: Locator.sl<AppRouter>().config(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
