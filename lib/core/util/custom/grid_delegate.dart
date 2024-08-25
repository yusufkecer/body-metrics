import 'package:flutter/material.dart';

@immutable
final class GridDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    return false;
  }

  const GridDelegate.profileImageGrid()
      : super(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1.25,
        );
}