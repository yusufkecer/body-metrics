import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LoadingDialog extends StatelessWidget {
  const LoadingDialog({required this.assetValue, super.key});

  final String assetValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Lottie.asset(
        assetValue,
      ),
    );
  }
}
