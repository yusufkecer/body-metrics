import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({required this.title, required this.icon, super.key, this.onPressed});

  final String title;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(title),
      icon: Icon(
        icon,
      ),
    );
  }
}
