import 'package:bodymetrics/core/index.dart';

import 'package:bodymetrics/injection/locator.dart';
import 'package:flutter/material.dart';

mixin DialogUtil {
  void loadingDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog(
          assetValue: AssetValue.loading.value.lottie,
        );
      },
    );
  }

  void showLottieError(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LottieDialog(
          assetValue: AssetValue.robotError.value.lottie,
          title: message,
        );
      },
    );
  }

  void showLottieSuccess(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LottieDialog(
          assetValue: AssetValue.success.value.lottie,
          title: message,
        );
      },
    );
  }

  Future<bool?> confirmDialog(String message) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return LottieConfirmDialog(
          assetValue: AssetValue.confirm.value.lottie,
          title: message,
        );
      },
    );
  }

  BuildContext get context {
    final context = Locator.sl<AppRouter>().navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context not found');
    }
    return context;
  }
}
