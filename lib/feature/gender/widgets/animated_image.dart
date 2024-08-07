import 'package:bmicalculator/core/index.dart';
import 'package:bmicalculator/feature/gender/widgets/gender_asset.dart';
import 'package:flutter/material.dart';

class AnimatedImage extends StatelessWidget {
  final GenderAsset genderAsset;
  final double size;
  const AnimatedImage({required this.genderAsset, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      height: size,
      width: size,
      duration: const ProductDuration.s2(),
      child: genderAsset,
    );
  }
}
