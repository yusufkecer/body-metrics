import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
final class ProductRadius extends BorderRadius {
  const ProductRadius.four() : super.all(const Radius.circular(4));
  const ProductRadius.ten() : super.all(const Radius.circular(10));
  const ProductRadius.twelve() : super.all(const Radius.circular(12));
  const ProductRadius.fourteen() : super.all(const Radius.circular(14));
  const ProductRadius.fifteen() : super.all(const Radius.circular(15));
  const ProductRadius.twenty() : super.all(const Radius.circular(20));
  const ProductRadius.twentyFive() : super.all(const Radius.circular(25));
}
