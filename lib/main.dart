import 'package:flutter/material.dart';
import 'package:myapp/core/index.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    InitApp.init();
    return MaterialApp.router(
      title: 'BMI Calculator',
      theme: Locator.instance.get<BaseTheme>().theme,
      routerConfig: Locator.instance.get<AppRouter>().config(),
      debugShowCheckedModeBanner: false,
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
