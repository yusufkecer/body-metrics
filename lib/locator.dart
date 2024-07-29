import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:myapp/locator.config.dart';

// ignore: invalid_annotation_target
@InjectableInit(initializerName: 'init')
abstract final class Locator {
  static final instance = GetIt.instance;

  static Future<void> locateServices() async {
    instance.init();
  }
}
