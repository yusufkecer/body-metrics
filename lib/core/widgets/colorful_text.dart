import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

class ColorfulText extends StatelessWidget {
  final List<Color>? colors;
  final String? text;
  final Duration? speed;
  const ColorfulText({
    required this.colors,
    required this.text,
    required this.speed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
        onTap: () {},
      ),
    );
  }
}
