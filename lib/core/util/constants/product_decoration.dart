import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductDecoration extends BoxDecoration {
  ProductDecoration.inputDecoration()
      : super(
          gradient: LinearGradient(
            colors: ProductColor().backgroundColorList.reversed.toList(),
          ),
          boxShadow: [
            BoxShadow(
              color: ProductColor().white,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: ProductColor().white,
          ),
          borderRadius: const ProductRadius.ten(),
        );

  ProductDecoration.buttonDecoration()
      : super(
          border: Border.all(
            width: 2,
            color: ProductColor().white,
          ),
          borderRadius: BorderRadius.circular(10),
        );
}
