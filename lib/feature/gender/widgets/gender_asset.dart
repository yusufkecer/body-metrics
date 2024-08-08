import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final class GenderAsset extends StatefulWidget {
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool? value)? onChanged;
  final String asset;
  final String gender;
  final Color? color;
  final IconData? icon;
  final bool? value;

  const GenderAsset({
    required this.asset,
    required this.gender,
    this.value,
    this.color,
    this.icon,
    super.key,
    this.onChanged,
  });

  @override
  State<GenderAsset> createState() => _GenderAssetState();
}

class _GenderAssetState extends State<GenderAsset> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Text(
              widget.gender,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(color: widget.color),
            ),
            HorizantalSpace.xs(),
            Icon(widget.icon, color: widget.color),
          ],
        ),
        Stack(
          children: [
            Lottie.asset(
              widget.asset,
              height: 250,
            ),
            Positioned(
              top: 20,
              right: 40,
              child: Checkbox(
                value: widget.value ?? false,
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
