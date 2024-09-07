import 'package:bodymetrics/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

@immutable
final class DialogTextButton extends StatelessWidget {
  const DialogTextButton({required this.title, required this.onPressed, super.key});

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
