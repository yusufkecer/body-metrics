import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProductIcon {
  venus(FontAwesomeIcons.venus),
  mars(FontAwesomeIcons.mars),
  user(FontAwesomeIcons.userAstronaut),
  share(FontAwesomeIcons.arrowUpRightFromSquare),
  arrowRight(FontAwesomeIcons.userAstronaut),
  plus(FontAwesomeIcons.plus),
  birthDay(FontAwesomeIcons.cakeCandles),
  ;

  final IconData icon;

  const ProductIcon(this.icon);
}
