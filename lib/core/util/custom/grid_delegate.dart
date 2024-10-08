import 'package:flutter/material.dart';

@immutable
final class GridDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  const GridDelegate.dashBoard()
      : super(
          crossAxisCount: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
        );

  const GridDelegate.profileImageGrid()
      : super(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1.25,
        );

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    return false;
  }
}
