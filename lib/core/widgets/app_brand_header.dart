import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class AppBrandHeader extends StatelessWidget {
  const AppBrandHeader({
    this.onBack,
    super.key,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPadding.authForm(),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => context.router.maybePop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ProductColor.instance.whiteAlpha20,
                borderRadius: const ProductRadius.twelve(),
                border: Border.all(color: ProductColor.instance.whiteAlpha40),
              ),
              child: Icon(
                ProductIcon.backArrow.icon,
                color: ProductColor.instance.white,
                size: 16,
              ),
            ),
          ),
          const Spacer(),
          Text(
            context.localizedAppName,
            style: context.textTheme.titleLarge?.copyWith(
              color: ProductColor.instance.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          HorizontalSpace.s(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ProductColor.instance.whiteAlpha20,
              border: Border.all(color: ProductColor.instance.whiteAlpha50),
            ),
            child: Icon(
              ProductIcon.heartMonitor.icon,
              color: ProductColor.instance.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
