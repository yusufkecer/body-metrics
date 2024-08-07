import 'package:bmicalculator/core/constants/space/horizantal_space.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final class GenderAsset extends StatelessWidget {
  final String asset;
  final String gender;
  final Color? color;
  final IconData? icon;
  const GenderAsset({required this.asset, required this.gender, this.color, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Text(
              gender,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(color: color),
            ),
            HorizantalSpace.xs(),
            Icon(icon, color: color),
          ],
        ),
        Lottie.asset(
          asset,
          height: 250,
        ),
      ],
    );
  }
}
