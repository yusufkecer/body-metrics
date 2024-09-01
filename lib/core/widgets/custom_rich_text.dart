import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomRichText extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomRichText({required this.title, required this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.titleMedium,
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetSpan(child: HorizontalSpace.xxs()),
          TextSpan(
            text: subTitle,
          ),
        ],
      ),
    );
  }
}
