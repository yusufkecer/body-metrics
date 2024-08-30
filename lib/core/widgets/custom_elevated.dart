import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomFilled extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CustomFilled({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ProductPadding.ten(),
      decoration: ProductDecoration.buttonDecoration(),
      child: FilledButton(
        onPressed: onPressed,
        child: Text(text, style: context.textTheme.titleMedium),
      ),
    );
  }
}
