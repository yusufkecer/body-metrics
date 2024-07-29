import 'package:flutter/material.dart';
import 'package:myapp/core/theme/base_theme.dart';
import 'package:myapp/locator.dart';

Future<void> main() async {
  await Locator.locateServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: Locator.instance.get<BaseTheme>().theme,
    );
  }
}
