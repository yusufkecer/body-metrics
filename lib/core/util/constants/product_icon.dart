import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProductIcon {
  venus(FontAwesomeIcons.venus),
  mars(FontAwesomeIcons.mars),
  user(FontAwesomeIcons.userAstronaut),
  share(FontAwesomeIcons.arrowUpRightFromSquare),
  plus(FontAwesomeIcons.plus),
  birthDay(FontAwesomeIcons.cakeCandles),
  arrowLeft(FontAwesomeIcons.arrowLeft),
  arrowRight(FontAwesomeIcons.arrowRight),
  check(FontAwesomeIcons.check),
  weight(FontAwesomeIcons.weightScale),
  chart(FontAwesomeIcons.chartLine),
  ;

  final IconData icon;

  // ignore: sort_constructors_first
  const ProductIcon(this.icon);
}
