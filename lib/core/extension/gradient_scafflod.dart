import 'package:bmicalculator/core/util/constants/product_color.dart';
import 'package:flutter/material.dart';

final class GradientScafflod extends Scaffold {
  GradientScafflod({super.key, Widget? body, AppBar? appBar})
      : super(
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ProductColor().deepPurple,
                  ProductColor().lightPurple,
                ],
              ),
            ),
            child: body,
          ),
        );
}
