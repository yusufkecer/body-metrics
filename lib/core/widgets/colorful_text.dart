import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ColorfulText extends StatelessWidget {
  final List<Color>? colors;
  final String text;
  final Duration speed;
  final void Function() onTap;

  const ColorfulText({
    required this.text,
    required this.onTap,
    this.speed = Durations.long3,
    this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProductPadding.ten(),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            text,
            speed: speed,
            colors: colors ?? ProductColor().colorfulList,
            textStyle: context.textTheme.titleMedium!,
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
