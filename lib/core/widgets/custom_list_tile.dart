import 'package:bodymetrics/core/extensions/context_extension.dart';
import 'package:bodymetrics/core/util/constants/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
    this.icon,
    this.title,
    this.onPressed, {
    super.key,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String title;
  final void Function()? onPressed;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: ProductPadding.horizontalEight(),
      shape: const RoundedRectangleBorder(
        borderRadius: ProductRadius.ten(),
      ),
      leading: Icon(icon, color: iconColor),
      title: Text(
        title.tr(),
        style: context.textTheme.titleMedium?.copyWith(color: textColor),
      ),
      onTap: onPressed,
    );
  }
}
