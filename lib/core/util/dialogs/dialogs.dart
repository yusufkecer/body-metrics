import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/widgets/lottie_dialog.dart';
import 'package:flutter/material.dart';

mixin Dialogs {
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LottieDialog(
          assetValue: AssetValue.robotError.value.lottie,
          title: LocaleKeys.register_name_empty,
        );
      },
    );
  }
}
