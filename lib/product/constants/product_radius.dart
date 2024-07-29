import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
final class ProductRadius extends BorderRadius {
  const ProductRadius.ten()
      : super.all(
          const Radius.circular(10.0),
        );
}
