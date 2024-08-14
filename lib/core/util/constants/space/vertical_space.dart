import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class VerticalSpace extends SizedBox {
  VerticalSpace.xxs({super.key}) : super(height: CustomSize.xxs.value);
  VerticalSpace.xs({super.key}) : super(height: CustomSize.xs.value);
  VerticalSpace.s({super.key}) : super(height: CustomSize.s.value);
  VerticalSpace.m({super.key}) : super(height: CustomSize.m.value);
  VerticalSpace.l({super.key}) : super(height: CustomSize.l.value);
  VerticalSpace.xl({super.key}) : super(height: CustomSize.xl.value);
}
