import 'package:bmicalculator/core/constants/space/horizantal_space.dart';
import 'package:bmicalculator/core/constants/space/vertical_space.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final class GenderAsset extends StatelessWidget {
  final String asset;
  final String gender;
  final Color? color;
  const GenderAsset({required this.asset, required this.gender, this.color, super.key});

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
            Icon(FontAwesomeIcons.venus, color: color),
          ],
        ),
        VerticalSpace.s(),
        Image.asset(
          asset,
          height: 200,
        ),
      ],
    );
  }
}
