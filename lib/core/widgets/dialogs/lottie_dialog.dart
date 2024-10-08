import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LottieDialog extends StatelessWidget {
  const LottieDialog({
    required this.assetValue,
    required this.title,
    super.key,
  });

  final String assetValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Lottie.asset(
        assetValue,
      ),
      content: Text(
        title,
        style: context.textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            LocaleKeys.dialog_ok.tr(),
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
