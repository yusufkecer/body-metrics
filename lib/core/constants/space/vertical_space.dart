import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class VerticalSpace extends SizedBox {
  VerticalSpace.xxs({super.key}) : super(height: SpaceValues.xxs.value);
  VerticalSpace.xs({super.key}) : super(height: SpaceValues.xs.value);
  VerticalSpace.s({super.key}) : super(height: SpaceValues.s.value);
  VerticalSpace.m({super.key}) : super(height: SpaceValues.m.value);
  VerticalSpace.l({super.key}) : super(height: SpaceValues.l.value);
  VerticalSpace.xl({super.key}) : super(height: SpaceValues.xl.value);
}
