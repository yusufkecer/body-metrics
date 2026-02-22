import 'package:flutter/material.dart';

@immutable
final class GlobalLoadingController {
  const GlobalLoadingController._();

  static final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  static int _activeCount = 0;

  static void show() {
    _activeCount++;
    if (!isLoading.value) {
      isLoading.value = true;
    }
  }

  static void hide() {
    if (_activeCount > 0) {
      _activeCount--;
    }

    if (_activeCount == 0 && isLoading.value) {
      isLoading.value = false;
    }
  }

  static Future<T> track<T>(Future<T> Function() operation) async {
    show();
    try {
      return await operation();
    } finally {
      hide();
    }
  }
}
