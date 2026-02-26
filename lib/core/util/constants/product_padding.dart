import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

@immutable
final class ProductPadding extends EdgeInsets {
  ProductPadding.four() : super.all(SpaceValues.xxs.value);
  ProductPadding.eight() : super.all(SpaceValues.xs.value);
  ProductPadding.ten() : super.all(SpaceValues.s.value);
  ProductPadding.twelve() : super.all(SpaceValues.ss.value);

  const ProductPadding.fifTeen() : super.all(15);
  const ProductPadding.bottomM() : super.only(bottom: 16);
  const ProductPadding.bottom8() : super.only(bottom: 8);
  const ProductPadding.left2Bottom8() : super.only(left: 2, bottom: 8);
  const ProductPadding.left16Right12() : super.only(left: 16, right: 12);
  const ProductPadding.right14() : super.only(right: 14);
  const ProductPadding.all4() : super.all(4);
  const ProductPadding.vertical2() : super.symmetric(vertical: 2);
  const ProductPadding.horizontal16Vertical18() : super.symmetric(horizontal: 16, vertical: 18);
  const ProductPadding.authForm() : super.fromLTRB(16, 12, 24, 0);
  const ProductPadding.backButton() : super.fromLTRB(16, 12, 16, 0);

  const ProductPadding.glassCard() : super.fromLTRB(24, 28, 24, 28);

  ProductPadding.horizontalEight()
      : super.symmetric(horizontal: SpaceValues.xs.value);

  ProductPadding.horizontalTen()
      : super.symmetric(horizontal: SpaceValues.s.value);

  ProductPadding.horizontalSVerticalXs()
      : super.symmetric(horizontal: SpaceValues.s.value, vertical: SpaceValues.xs.value);

  ProductPadding.horizontalTwentyFour()
      : super.symmetric(horizontal: SpaceValues.xl.value);

  ProductPadding.verticalEight()
      : super.symmetric(vertical: SpaceValues.xs.value);

  ProductPadding.verticalTwelve()
      : super.symmetric(vertical: SpaceValues.ss.value);

  ProductPadding.rightXs() : super.only(right: SpaceValues.xs.value);
  ProductPadding.bottomXs() : super.only(bottom: SpaceValues.xs.value);
  ProductPadding.bottomSs() : super.only(bottom: SpaceValues.ss.value);
}
