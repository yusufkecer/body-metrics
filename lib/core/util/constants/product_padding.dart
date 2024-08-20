import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductPadding extends EdgeInsets {
  ProductPadding.ten() : super.all(SpaceValues.s.value);
  const ProductPadding.fifTeen() : super.all(15);
}
