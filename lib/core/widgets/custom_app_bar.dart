import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.action,
    this.title,
    this.fullName,
  });

  final IconButton? leading;
  final Widget? action;
  final String? title;
  final String? fullName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title?.tr(args: [fullName ?? '']) ?? ''),
      actions: [action ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
