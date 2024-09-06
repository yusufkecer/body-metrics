part of '../height_picker.dart';

sealed class HeightSelectorState extends Equatable {
  final int? page;
  final double? height;
  const HeightSelectorState({this.page, this.height});

  @override
  List<Object> get props => [page ?? 0, height ?? 0];
}

final class HeightSelectorInitial extends HeightSelectorState {
  const HeightSelectorInitial({
    super.height,
    super.page,
  });
}
