import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomElevated extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CustomElevated({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const ProductPadding.ten(),
      decoration: ProductDecoration.buttonDecoration(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ProductColor().seedColor,
        ),
        onPressed: onPressed,
        child: Text(text, style: context.textTheme.titleMedium),
      ),
    );
  }
}
