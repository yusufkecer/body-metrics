import 'package:flutter/material.dart';

@immutable
final class CustomSize extends Size {
  const CustomSize(super.width, super.height);

  const CustomSize.dots() : super(20, 10);
  const CustomSize.activeDot() : super.square(10);
  const CustomSize.dashboardTitle() : super.square(100);
}
