import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ColorfulText extends StatelessWidget {
  final List<Color>? colors;
  final String? text;
  final Duration? speed;
  final void Function() onTap;
  const ColorfulText({
    required this.colors,
    required this.text,
    required this.speed,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPadding.ten(),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            text!,
            speed: speed!,
            colors: colors!,
            textStyle: context.textTheme.titleMedium!,
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
