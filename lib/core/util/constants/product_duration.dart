import 'package:flutter/material.dart';

@immutable
final class ProductDuration extends Duration {
  const ProductDuration.s1() : super(seconds: 1);
  const ProductDuration.ms100() : super(milliseconds: 100);
  const ProductDuration.s2() : super(seconds: 2);
}
