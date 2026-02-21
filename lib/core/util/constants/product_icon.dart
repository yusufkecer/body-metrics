import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProductIcon {
  venus(FontAwesomeIcons.venus),
  mars(FontAwesomeIcons.mars),
  user(FontAwesomeIcons.userLarge),
  users(FontAwesomeIcons.users),
  share(FontAwesomeIcons.arrowUpRightFromSquare),
  plus(FontAwesomeIcons.plus),
  minus(FontAwesomeIcons.minus),
  straight(FontAwesomeIcons.lock),
  calendar(FontAwesomeIcons.calendar),
  birthDay(FontAwesomeIcons.cakeCandles),
  arrowLeft(FontAwesomeIcons.arrowLeft),
  arrowRight(FontAwesomeIcons.arrowRight),
  check(FontAwesomeIcons.check),
  weight(FontAwesomeIcons.weightScale),
  chart(FontAwesomeIcons.chartLine),
  userCheck(FontAwesomeIcons.userCheck),
  diff(FontAwesomeIcons.codeCompare),
  arrowUp(FontAwesomeIcons.arrowUp),
  arrowDown(FontAwesomeIcons.arrowDown),
  trendingFlat(FontAwesomeIcons.arrowTrendUp);

  final IconData icon;

  // ignore: sort_constructors_first
  const ProductIcon(this.icon);
}
