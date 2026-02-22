import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class GlobalLoadingOverlay extends StatelessWidget {
  const GlobalLoadingOverlay({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlobalLoadingController.isLoading,
      builder: (context, isLoading, _) {
        return Stack(
          children: [
            child,
            if (isLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  child: ColoredBox(
                    color: Colors.black45,
                    child: Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        padding: ProductPadding.ten(),
                        decoration: BoxDecoration(
                          color: ProductColor.instance.seedColor.withAlpha(220),
                          borderRadius: const ProductRadius.fifteen(),
                        ),
                        child: Lottie.asset(AssetValue.loading.value.lottie),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
