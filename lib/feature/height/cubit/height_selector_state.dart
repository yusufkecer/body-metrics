part of '../height.dart';

sealed class HeightSelectorState extends Equatable {
  final int _page;
  final double _height;
  const HeightSelectorState(this._page, this._height);

  @override
  List<Object> get props => [_page];
}

final class HeightSelectorInitial extends HeightSelectorState {
  const HeightSelectorInitial(
    super.page,
    super.height,
  );
}
