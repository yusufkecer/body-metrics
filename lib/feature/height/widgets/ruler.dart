import 'package:bmicalculator/core/index.dart';
import 'package:flutter/material.dart';

class Ruler extends StatelessWidget {
  final PageController pageController;
  final int maxValue;
  final double selectedHeight;

  const Ruler({
    required this.pageController,
    required this.maxValue,
    required this.selectedHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: context.height,
      child: PageView.builder(
        clipBehavior: Clip.antiAlias,
        scrollDirection: Axis.vertical,
        reverse: true,
        padEnds: false,
        itemBuilder: (context, index) {
          final current = index + 1;
          final selectedCentimeter = selectedHeight.round() == current;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$current',
                style: TextStyle(
                  color: selectedCentimeter
                      ? ProductColor().pink
                      : current % 5 == 0
                          ? ProductColor().white
                          : ProductColor().white.withOpacity(.5),
                  fontWeight: current % 5 == 0 ? FontWeight.bold : null,
                ),
              ),
              Container(
                color: current % 5 == 0 ? ProductColor().white : ProductColor().white.withOpacity(.5),
                height: 2,
                width: current % 5 == 0 ? 15 : 10,
              ),
            ],
          );
        },
        controller: pageController,
        itemCount: maxValue,
      ),
    );
  }
}
