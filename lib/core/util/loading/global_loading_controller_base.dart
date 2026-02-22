import 'package:flutter/foundation.dart';

abstract interface class GlobalLoadingControllerBase {
  ValueListenable<bool> get isLoading;
  void show();
  void hide();
  Future<T> track<T>(Future<T> Function() operation);
}
