import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class HorizantalSpace extends SizedBox {
  HorizantalSpace.xxs({super.key}) : super(width: CustomSize.xxs.value);
  HorizantalSpace.xs({super.key}) : super(width: CustomSize.xs.value);
  HorizantalSpace.s({super.key}) : super(width: CustomSize.s.value);
  HorizantalSpace.m({super.key}) : super(width: CustomSize.m.value);
  HorizantalSpace.l({super.key}) : super(width: CustomSize.l.value);
  HorizantalSpace.xl({super.key}) : super(width: CustomSize.xl.value);
}
