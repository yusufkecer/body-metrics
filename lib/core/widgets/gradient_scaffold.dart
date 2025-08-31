import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class GradientScaffold extends Scaffold {
  GradientScaffold({super.key, Widget? body, super.appBar})
      : super(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ProductColor.instance.backgroundColorList,
              ),
            ),
            child: body,
          ),
        );
}
