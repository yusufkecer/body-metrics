import 'package:bodymetrics/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LottieDialog extends StatelessWidget {
  final String assetValue;
  final String title;
  const LottieDialog({required this.assetValue, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Lottie.asset(assetValue),
      content: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            LocaleKeys.ok,
          ),
        ),
      ],
    );
  }
}
