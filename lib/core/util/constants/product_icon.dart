import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProductIcon {
  venus(FontAwesomeIcons.venus),
  mars(FontAwesomeIcons.mars),
  user(FontAwesomeIcons.user),
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
  arrowDown(Icons.arrow_downward_rounded),
  menu(Icons.menu),
  addRounded(Icons.add_rounded),
  trendingFlat(FontAwesomeIcons.arrowTrendUp),
  backArrow(Icons.arrow_back_ios_new_rounded),
  heartMonitor(Icons.monitor_heart_rounded),
  eyeOpen(Icons.visibility_outlined),
  eyeClosed(Icons.visibility_off_outlined),
  email(Icons.alternate_email_rounded),
  lockOutline(Icons.lock_outline_rounded),
  lockReset(Icons.lock_reset_rounded),
  pin(Icons.pin_outlined);

  final IconData icon;

  // ignore: sort_constructors_first
  const ProductIcon(this.icon);
}
