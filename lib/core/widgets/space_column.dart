import 'package:flutter/material.dart';

class SpaceColumn extends StatelessWidget {
  final List<Widget> children;
  final double space;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const SpaceColumn({
    required this.children,
    required this.space,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(
        children.length * 2 - 1,
        (index) {
          if (index.isEven) {
            return children[index ~/ 2];
          } else {
            return SizedBox(
              height: space,
            );
          }
        },
      ),
    );
  }
}
