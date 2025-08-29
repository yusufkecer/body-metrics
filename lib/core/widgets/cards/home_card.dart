import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.children,
    required this.buttonTitle,
    required this.animationController,
    super.key,
  });

  final void Function() onPressed;
  final List<Widget> children;
  final String title;
  final String buttonTitle;
  final IconData icon;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animationController,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: Card(
          child: Padding(
            padding: ProductPadding.ten(),
            child: Padding(
              padding: ProductPadding.four().copyWith(top: 0, bottom: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: const CustomSize.dashboardTitle().width,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            icon,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          title.tr(),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: const CustomSize.dashboardTitle().width,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: onPressed,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              buttonTitle.tr(),
                              style: context.textTheme.titleMedium?.copyWith(
                                color: ProductColor().white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...children,
                  VerticalSpace.s(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
