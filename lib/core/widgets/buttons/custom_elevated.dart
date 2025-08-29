import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomFilled extends StatelessWidget {
  const CustomFilled({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ProductPadding.ten(),
      decoration: ProductDecoration.buttonDecoration(),
      child: FilledButton(
        onPressed: onPressed,
        child: Text(text.tr(), style: context.textTheme.titleMedium),
      ),
    );
  }
}
