part of '../home.dart';

enum _ExpandedCard {
  none,
  chart,
  list;

  int adjustLength(int length) {
    if (this == _ExpandedCard.list) {
      return length;
    }
    return length >= 2 ? 2 : length;
  }

  Size? customSize(BuildContext context) {
    final Size size;
    final height = context.height * ThemeConstants.homeCardSize;
    this != _ExpandedCard.none ? size = Size(context.width, 0) : size = Size(context.width, height);
    return size;
  }
}
