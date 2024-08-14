import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class GradientScafflod extends Scaffold {
  GradientScafflod({super.key, Widget? body, super.appBar})
      : super(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ProductColor().backgroundColorList,
              ),
            ),
            child: body,
          ),
        );
}
