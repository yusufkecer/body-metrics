import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LoadingDialog extends StatelessWidget {
  const LoadingDialog({required this.assetValue, this.size = 200, super.key});

  final String assetValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        width: size,
        height: size,
        child: Lottie.asset(assetValue),
      ),
    );
  }
}
