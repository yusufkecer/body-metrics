part of 'save_height_cubit.dart';

sealed class SaveHeightState extends Equatable {
  const SaveHeightState();

  @override
  List<Object> get props => [];
}

final class SaveHeightInitial extends SaveHeightState {}

final class SaveHeightLoading extends SaveHeightState {}

final class SaveHeightSuccess extends SaveHeightState {}

final class SaveHeightError extends SaveHeightState {}
