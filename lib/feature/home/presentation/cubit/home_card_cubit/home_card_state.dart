part of 'home_card_cubit.dart';

abstract class HomeCardState extends Equatable {
  const HomeCardState();

  @override
  List<Object?> get props => [];
}

class HomeCardInitial extends HomeCardState {
  const HomeCardInitial();
}

class HomeCardLoaded extends HomeCardState {
  const HomeCardLoaded({
    required this.expandedCard,
    required this.shouldAnimateList,
    required this.shouldAnimateChart,
    required this.itemLength,
  });

  final ExpandedCard expandedCard;
  final bool shouldAnimateList;
  final bool shouldAnimateChart;
  final int itemLength;

  @override
  List<Object?> get props =>
      [expandedCard, shouldAnimateList, shouldAnimateChart, itemLength];
}
