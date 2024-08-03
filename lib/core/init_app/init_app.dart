import 'package:bmicalculator/injection/locator.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class InitApp {
  static Future<void> init() async {
    await Locator.locateServices();
  }
}
