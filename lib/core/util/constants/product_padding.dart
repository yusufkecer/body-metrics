import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductPadding extends EdgeInsets {
  ProductPadding.four() : super.all(SpaceValues.xxs.value);
  ProductPadding.eight() : super.all(SpaceValues.xs.value);
  ProductPadding.ten() : super.all(SpaceValues.s.value);
  ProductPadding.twelve() : super.all(SpaceValues.ss.value);

  const ProductPadding.fifTeen() : super.all(15);

  ProductPadding.horizontalTen()
      : super.symmetric(horizontal: SpaceValues.s.value);

  ProductPadding.horizontalEight()
      : super.symmetric(horizontal: SpaceValues.xs.value);

  ProductPadding.verticalEight()
      : super.symmetric(vertical: SpaceValues.xs.value);

  ProductPadding.verticalTwelve()
      : super.symmetric(vertical: SpaceValues.ss.value);
}
