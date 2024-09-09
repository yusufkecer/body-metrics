part of '../home.dart';

enum _ExpandedCard {
  none,
  chart,
  list;

  int length(int length) {
    switch (this) {
      case _ExpandedCard.list:
        return length;
      // ignore: no_default_cases
      default:
        return 2;
    }
  }

  Size? size(BuildContext context) {
    switch (this) {
      case _ExpandedCard.none:
        return Size(context.width, context.height * 0.38);
      // ignore: no_default_cases
      default:
        return Size(context.width, 0);
    }
  }
}
