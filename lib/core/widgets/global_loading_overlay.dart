import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class GlobalLoadingOverlay extends StatelessWidget {
  const GlobalLoadingOverlay({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final loadingController = GlobalLoadingController.contract;
    return ValueListenableBuilder<bool>(
      valueListenable: loadingController.isLoading,
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
                      child: LoadingDialog(
                        assetValue: AssetValue.loading.value.lottie,
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
