import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
abstract final class HorizantalSpace extends SizedBox {
  HorizantalSpace.xxs({super.key}) : super(width: SpaceValues.xxs.value);
  HorizantalSpace.xs({super.key}) : super(width: SpaceValues.xs.value);
  HorizantalSpace.s({super.key}) : super(width: SpaceValues.s.value);
  HorizantalSpace.m({super.key}) : super(width: SpaceValues.m.value);
  HorizantalSpace.l({super.key}) : super(width: SpaceValues.l.value);
  HorizantalSpace.xl({super.key}) : super(width: SpaceValues.xl.value);
}
