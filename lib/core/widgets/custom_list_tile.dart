import 'package:bodymetrics/core/extensions/context_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
    this.icon,
    this.title,
    this.onPressed, {
    super.key,
  });

  final IconData icon;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title.tr(), style: context.textTheme.titleMedium),
      onTap: onPressed,
    );
  }
}
