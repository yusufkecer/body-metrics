import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class VerticalSpace extends SizedBox {
  /// 4px
  VerticalSpace.xxs({super.key}) : super(height: SpaceValues.xxs.value);

  /// 8px
  VerticalSpace.xs({super.key}) : super(height: SpaceValues.xs.value);

  /// 10px
  VerticalSpace.s({super.key}) : super(height: SpaceValues.s.value);

  /// 12px
  VerticalSpace.m({super.key}) : super(height: SpaceValues.m.value);

  /// 16px
  VerticalSpace.l({super.key}) : super(height: SpaceValues.l.value);

  /// 20px
  VerticalSpace.xl({super.key}) : super(height: SpaceValues.xl.value);
}
