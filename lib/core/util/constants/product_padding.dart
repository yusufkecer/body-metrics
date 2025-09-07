import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductPadding extends EdgeInsets {
  ProductPadding.four() : super.all(SpaceValues.xxs.value);
  ProductPadding.eight() : super.all(SpaceValues.xs.value);
  ProductPadding.ten() : super.all(SpaceValues.s.value);

  const ProductPadding.fifTeen() : super.all(15);
  
}
