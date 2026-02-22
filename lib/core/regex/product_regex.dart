import 'package:flutter/material.dart';

@immutable
final class ProductRegex {
  const ProductRegex._();

  static final RegExp email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
}
