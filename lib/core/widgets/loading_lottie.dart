import 'package:bodymetrics/core/util/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AssetValue.loading.value.lottie,
      ),
    );
  }
}
