import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

class SelectedHeight extends StatelessWidget {
  final int selectedHeight;
  const SelectedHeight({
    required this.selectedHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: ProductColor().white,
        borderRadius: const ProductRadius.ten(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: SpaceValues.s.value,
            width: SpaceValues.s.value,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ProductColor().deepPurple,
                borderRadius: const ProductRadius.ten(),
              ),
            ),
          ),
          Text(
            '$selectedHeight',
            style: context.textTheme.titleMedium?.copyWith(
              color: ProductColor().deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
