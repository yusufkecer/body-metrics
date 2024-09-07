import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
    required this.child,
    required this.size,
    super.key,
  });

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      height: size,
      width: size,
      duration: const ProductDuration.s2(),
      child: child,
    );
  }
}
