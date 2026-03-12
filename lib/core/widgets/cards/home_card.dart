import 'dart:ui';

import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
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
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _buttonAnimController;
  late Animation<double> _buttonScaleAnim;
  late Animation<double> _buttonGlowAnim;

  @override
  void initState() {
    super.initState();

    _buttonAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _buttonScaleAnim = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(parent: _buttonAnimController, curve: Curves.easeInOut),
    );

    _buttonGlowAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonAnimController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _buttonAnimController.dispose();
    super.dispose();
  }

  void _handleButtonTap() {
    _buttonAnimController.forward().then((_) {
      _buttonAnimController.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animationController,
      child: ClipRRect(
        borderRadius: const ProductRadius.twenty(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: ProductColor.instance.cardBg,
              borderRadius: const ProductRadius.twenty(),
              border: Border.all(color: ProductColor.instance.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: ProductColor.instance.blackAlpha40,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const ProductPadding.fifTeen().copyWith(
                top: 12,
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
                          alignment: AlignmentDirectional.centerStart,
                          child: Icon(
                            widget.icon,
                            color: ProductColor.instance.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.title.tr(),
                          style: context.textTheme.titleMedium?.copyWith(
                            color: ProductColor.instance.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: const CustomSize.dashboardTitle().width,
                        child: widget.showButton
                            ? Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: _AnimatedExpandButton(
                                  buttonTitle: widget.buttonTitle,
                                  onTap: _handleButtonTap,
                                  scaleAnim: _buttonScaleAnim,
                                  glowAnim: _buttonGlowAnim,
                                ),
                              )
                            : VerticalSpace.xxl(),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(bottom: SpaceValues.ss.value),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ProductColor.instance.transparent,
                          ProductColor.instance.white.withAlpha(30),
                          ProductColor.instance.transparent,
                        ],
                      ),
                    ),
                  ),
                  ...widget.children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedExpandButton extends StatelessWidget {
  const _AnimatedExpandButton({
    required this.buttonTitle,
    required this.onTap,
    required this.scaleAnim,
    required this.glowAnim,
  });

  final String buttonTitle;
  final VoidCallback onTap;
  final Animation<double> scaleAnim;
  final Animation<double> glowAnim;

  bool get _isExpanded {
    final lower = buttonTitle.toLowerCase();
    return lower.contains('less') ||
        lower.contains('daha az') ||
        lower.contains('weniger');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([scaleAnim, glowAnim]),
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnim.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ProductColor.instance.white.withAlpha(
                  _isExpanded ? 25 : 0,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ProductColor.instance.white.withAlpha(
                    _isExpanded ? 50 : 0,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      final slide = Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: slide, child: child),
                      );
                    },
                    child: Text(
                      buttonTitle.tr(),
                      key: ValueKey<String>(buttonTitle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: ProductColor.instance.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutBack,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ProductColor.instance.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
