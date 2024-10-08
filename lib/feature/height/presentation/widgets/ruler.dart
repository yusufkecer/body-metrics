part of '../height_picker.dart';

@immutable
final class _Ruler extends StatelessWidget with HeightCalculate {
  const _Ruler({
    required this.pageController,
    required this.maxValue,
    required this.minValue,
    required this.selectedHeight,
  });

  final PageController pageController;
  final int maxValue;
  final int minValue;
  final int selectedHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: context.height,
      child: RepaintBoundary(
        child: PageView.builder(
          clipBehavior: Clip.antiAlias,
          scrollDirection: Axis.vertical,
          reverse: true,
          pageSnapping: false,
          itemBuilder: (context, index) {
            final adjustedIndex = calculateIndex(selectedHeight - 1, index, minValue);
            final selectedCentimeter = isSelectedCentimeter(selectedHeight - 1, adjustedIndex);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (selectedCentimeter)
                  PickedWidget(selectedValue: adjustedIndex)
                else
                  Text(
                    '$adjustedIndex',
                    style: TextStyle(
                      color: isMultipleOfFive(adjustedIndex) ? ProductColor().white : ProductColor().whiteEightTenths,
                      fontWeight: isMultipleOfFive(adjustedIndex) ? FontWeight.bold : null,
                    ),
                  ),
                Container(
                  color: isMultipleOfFive(adjustedIndex) ? ProductColor().white : ProductColor().whiteEightTenths,
                  height: 2,
                  width: isMultipleOfFive(adjustedIndex) ? 15 : 10,
                ),
              ],
            );
          },
          controller: pageController,
          itemCount: maxValue - minValue,
        ),
      ),
    );
  }
}

mixin HeightCalculate {
  int calculateIndex(int selectedHeight, int index, int minValue) {
    final adjustedIndex = (minValue + 1) + index;
    return adjustedIndex;
  }

  bool isSelectedCentimeter(int selectedHeight, int adjustedIndex) {
    final selectedCentimeter = selectedHeight == adjustedIndex - 1;
    return selectedCentimeter;
  }

  bool isMultipleOfFive(int adjustedIndex) {
    final multipleOfFive = adjustedIndex % 5 == 0;
    return multipleOfFive;
  }
}
