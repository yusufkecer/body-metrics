part of 'height_picker_cubit.dart';

sealed class HeightSelectorState extends Equatable {
  const HeightSelectorState({this.userHeight, this.height});

  final int? userHeight;
  final double? height;

  @override
  List<Object> get props => [userHeight ?? 0, height ?? 0];
}

final class HeightSelectorUpdateHeight extends HeightSelectorState {
  const HeightSelectorUpdateHeight({
    super.height,
    super.userHeight,
  });
}
