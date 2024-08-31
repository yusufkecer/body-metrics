import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ChipButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color? borderColor;
  const ChipButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: InkWell(
        child: Chip(
          side: borderColor.isNotNull ? BorderSide(color: borderColor!) : null,
          backgroundColor: backgroundColor,
          labelPadding: ProductPadding.ten(),
          label: Text(
            text,
          ),
        ),
      ),
    );
  }
}
