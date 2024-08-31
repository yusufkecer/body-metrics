import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ChipButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  const ChipButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.borderColor,
    super.key,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: InkWell(
        onTap: onPressed,
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          side: borderColor.isNotNull
              ? BorderSide(
                  color: borderColor!,
                  width: 3,
                )
              : null,
          backgroundColor: backgroundColor,
          labelPadding: ProductPadding.four(),
          label: SizedBox(
            width: context.width * 0.15,
            child: Text(
              text,
              style: context.textTheme.titleSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
