import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    super.key,
    this.leading,
    this.action,
    this.titleWidget,
    this.translate = true,
  });

  final IconButton? leading;
  final Widget? action;
  final String? title;
  final Widget? titleWidget;
  final bool translate;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: titleWidget ??
          (title.isNullOrEmpty
              ? null
              : Text(translate ? title!.tr() : title!)),
      actions: [action ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
