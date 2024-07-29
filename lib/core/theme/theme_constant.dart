import 'package:flutter/material.dart';
import 'package:myapp/product/constants/product_radius.dart';

@immutable
abstract final class ThemeConstants {
  static const radius = ProductRadius.ten();
  static const elevation = 2.0;
}
