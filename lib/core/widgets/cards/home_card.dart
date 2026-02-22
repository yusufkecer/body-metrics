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
    this.showButton = true,
    super.key,
  });

  final void Function() onPressed;
  final List<Widget> children;
  final String title;
  final String buttonTitle;
  final IconData icon;
  final bool showButton;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animationController,
      child: AnimatedSize(
        duration: Durations.medium1,
        child: Card(
          child: Padding(
            padding: const ProductPadding.fifTeen().copyWith(
              top: 0,
              bottom: SpaceValues.l.value,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: const CustomSize.dashboardTitle().width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(icon),
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
                      child: showButton
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: onPressed,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  buttonTitle.tr(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        color: ProductColor.instance.white,
                                      ),
                                ),
                              ),
                            )
                          : SizedBox(height: SpaceValues.xxl.value),
                    ),
                  ],
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
