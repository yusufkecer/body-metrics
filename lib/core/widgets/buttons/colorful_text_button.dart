import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class ColorfulTextButton extends StatelessWidget {
  const ColorfulTextButton({required this.onTap, super.key});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(minimumSize: Size.zero),
        child: Text(
          LocaleKeys.cont.tr(),
          style: context.textTheme.titleMedium?.copyWith(
            color: ProductColor.instance.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
