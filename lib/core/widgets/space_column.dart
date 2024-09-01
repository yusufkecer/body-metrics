import 'package:flutter/material.dart';

class SpaceColumn extends StatelessWidget {
  final List<Widget> children;
  final double space;
  const SpaceColumn({required this.children, required this.space, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
