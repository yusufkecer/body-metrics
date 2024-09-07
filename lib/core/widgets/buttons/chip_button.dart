import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ChipButton extends StatelessWidget {
  const ChipButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.isSelected,
    this.borderColor,
    super.key,
    this.textColor,
  });

  final String text;
  final void Function({required bool value}) onPressed;
  final bool isSelected;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: ChoiceChip(
        selected: false,
        onSelected: (value) => onPressed(value: value),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        side: borderColor.isNotNull
            ? BorderSide(
                color: borderColor!,
                width: 2,
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
    );
  }
}
