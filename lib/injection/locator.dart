import 'package:bmicalculator/injection/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// ignore: invalid_annotation_target
@InjectableInit(initializerName: 'init')
abstract final class Locator {
  static final sl = GetIt.instance;

  static Future<void> locateServices() async {
    sl.init();
  }
}
