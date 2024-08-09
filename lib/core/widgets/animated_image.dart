import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

class AnimatedImage extends StatelessWidget {
  final Widget child;
  final double size;
  const AnimatedImage({required this.child, required this.size, super.key});

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
