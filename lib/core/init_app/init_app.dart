import 'package:myapp/locator.dart';

abstract final class InitApp {
  static Future<void> init() async {
    await Locator.locateServices();
  }
}
