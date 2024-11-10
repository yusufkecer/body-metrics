import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Lottie.asset(
          width: 300,
          AssetValue.loading.value.lottie,
        ),
      ),
    );
  }
}
