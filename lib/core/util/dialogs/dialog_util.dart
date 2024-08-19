import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/lottie_dialog.dart';
import 'package:bodymetrics/injection/locator.dart';

import 'package:flutter/material.dart';

mixin DialogUtil {
  void showLottieError(String message) {
    showDialog<void>(
      context: Locator.sl<AppRouter>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return LottieDialog(
          assetValue: AssetValue.robotError.value.lottie,
          title: message,
        );
      },
    );
  }
}
