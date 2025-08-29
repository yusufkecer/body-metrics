import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@immutable
final class CustomError extends StatelessWidget {
  const CustomError({this.text, super.key});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const ProductPadding.fifTeen().copyWith(bottom: 10),
          child: Column(
            children: [
              Text(
                text ?? '404',
                style: context.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Lottie.asset(
            AssetValue.generalError.value.lottie,
          ),
        ),
        CustomFilled(
          text: LocaleKeys.back,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        VerticalSpace.l(),
      ],
    );
  }
}
