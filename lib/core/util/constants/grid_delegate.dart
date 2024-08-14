import 'package:flutter/rendering.dart';

final class GridDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    return false;
  }

  GridDelegate.profileImageGrid()
      : super(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1.1,
        );
}
