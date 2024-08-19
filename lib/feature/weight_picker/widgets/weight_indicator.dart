part of '../weight_picker.dart';

class WeightIndicator extends StatelessWidget {
  final int selectedWeight;
  final PageController weightPickerController;
  final double minVal;
  final double maxVal;
  final bool isDisabled;
  const WeightIndicator({
    required this.selectedWeight,
    required this.weightPickerController,
    required this.minVal,
    required this.maxVal,
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: PageView.builder(
        physics: isDisabled ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
        controller: weightPickerController,
        itemCount: (maxVal - minVal).toInt(),
        pageSnapping: false,
        itemBuilder: (context, index) {
          return _buildWeightText(index + minVal.toInt(), context);
        },
      ),
    );
  }

  Widget _buildWeightText(int weight, BuildContext context) {
    final isActive = selectedWeight == weight;
    final opacity = _calculateOpacity(weight);
    final fontSize = _calculateFontSize(weight);

    return Align(
      child: Text(
        '$weight',
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: isActive ? FontWeight.normal : null,
          color: ProductColor().white.withOpacity(opacity),
          fontSize: fontSize,
        ),
      ),
    );
  }

  double _calculateOpacity(int weight) {
    final difference = (weight - selectedWeight).abs();
    if (difference == 0) return 1;
    if (difference == 1) return 0.8;
    if (difference == 2) return 0.5;
    return 0.3;
  }

  double _calculateFontSize(int weight) {
    final difference = (weight - selectedWeight).abs();
    if (difference == 0) return 34;
    if (difference == 1) return 24;
    if (difference == 2) return 16;
    return 14;
  }
}
