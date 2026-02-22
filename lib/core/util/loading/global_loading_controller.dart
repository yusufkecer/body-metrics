import 'package:bodymetrics/core/index.dart';
import 'package:flutter/foundation.dart';

final class GlobalLoadingController implements GlobalLoadingControllerBase {
  GlobalLoadingController._();

  static final GlobalLoadingController _instance = GlobalLoadingController._();
  static GlobalLoadingControllerBase get contract => _instance;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  int _activeCount = 0;

  @override
  ValueListenable<bool> get isLoading => _isLoading;

  @override
  void show() {
    _activeCount++;
    if (!_isLoading.value) {
      _isLoading.value = true;
    }
  }

  @override
  void hide() {
    if (_activeCount > 0) {
      _activeCount--;
    }

    if (_activeCount == 0 && _isLoading.value) {
      _isLoading.value = false;
    }
  }

  @override
  Future<T> track<T>(Future<T> Function() operation) async {
    show();
    try {
      return await operation();
    } finally {
      hide();
    }
  }
}
