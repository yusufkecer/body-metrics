import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class HorizontalSpace extends SizedBox {
  HorizontalSpace.xxs({super.key}) : super(width: SpaceValues.xxs.value);
  HorizontalSpace.xs({super.key}) : super(width: SpaceValues.xs.value);
  HorizontalSpace.s({super.key}) : super(width: SpaceValues.s.value);
  HorizontalSpace.m({super.key}) : super(width: SpaceValues.m.value);
  HorizontalSpace.l({super.key}) : super(width: SpaceValues.l.value);
  HorizontalSpace.xl({super.key}) : super(width: SpaceValues.xl.value);
}
