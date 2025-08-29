import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomRichText extends StatelessWidget {
  const CustomRichText({required this.title, required this.subTitle, this.icon, super.key});

  final IconData? icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyLarge,
        children: [
          if (icon != null) ...[
            WidgetSpan(
              child: Icon(
                icon,
                size: 16,
              ),
            ),
            WidgetSpan(
              child: HorizontalSpace.s(),
            ),
          ],
          TextSpan(
            text: title.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetSpan(
            child: HorizontalSpace.xxs(),
          ),
          TextSpan(
            text: subTitle.tr(),
          ),
        ],
      ),
    );
  }
}
