part of 'height_picker_cubit.dart';



sealed class HeightSelectorState extends Equatable {
  const HeightSelectorState({this.page, this.height});

  final int? page;
  final double? height;

  @override
  List<Object> get props => [page ?? 0, height ?? 0];
}

final class HeightSelectorUpdateHeight extends HeightSelectorState {
  const HeightSelectorUpdateHeight({
    super.height,
    super.page,
  });
}
