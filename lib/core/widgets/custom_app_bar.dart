import 'package:flutter/material.dart';

@immutable
final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconButton? leading;
  final Widget? action;
  final String? title;

  const CustomAppBar({
    super.key,
    this.leading,
    this.action,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title ?? ''),
      actions: [action ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
