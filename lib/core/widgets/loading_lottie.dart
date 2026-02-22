import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: LoadingDialog(
          assetValue: AssetValue.loading.value.lottie,
        ),
      ),
    );
  }
}
