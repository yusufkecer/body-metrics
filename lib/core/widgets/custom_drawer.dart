import 'package:bodymetrics/core/index.dart';
import 'package:bodymetrics/core/util/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

@immutable
final class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    required this.zoomDrawerController,
    required this.mainScreen,
    required this.menuScreen,
    this.menuBackgroundColor,
    this.borderRadius,
    super.key,
  });
  final ZoomDrawerController zoomDrawerController;
  final Widget mainScreen;
  final Widget menuScreen;
  final Color? menuBackgroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      borderRadius: borderRadius ?? 25,
      menuBackgroundColor: menuBackgroundColor ?? ProductColor().seedColor,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      duration: Durations.short4,
      menuScreenTapClose: true,
      mainScreenTapClose: true,
      shadowLayer2Color: ProductColor().blue,
      shadowLayer1Color: ProductColor().drawerBg2,
      menuScreen: menuScreen,
      mainScreen: mainScreen,
    );
  }
}
