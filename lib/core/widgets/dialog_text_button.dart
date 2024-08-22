import 'package:bodymetrics/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

@immutable
final class DialogTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const DialogTextButton({required this.title, super.key, required this.onPressed});

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
