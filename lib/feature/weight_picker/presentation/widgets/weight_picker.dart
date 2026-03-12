part of '../weight_picker.dart';

@immutable
final class _WeightPickerWidget extends StatelessWidget {
  const _WeightPickerWidget({
    required this.selectedWeight,
    required this.weightPickerController,
    required this.minVal,
    required this.maxVal,
    this.isDisabled = false,
    this.height = 56,
  });

  final int selectedWeight;
  final PageController weightPickerController;
  final double minVal;
  final double maxVal;
  final bool isDisabled;
  final double height;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: height,
            child: PageView.builder(
              physics: isDisabled
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              controller: weightPickerController,
              itemCount: (maxVal - minVal).toInt(),
              pageSnapping: false,
              itemBuilder: (context, index) {
                return _buildWeightText(index + minVal.toInt(), context);
              },
            ),
          ),
          IgnorePointer(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ProductColor.instance.seedColor,
                    ProductColor.instance.seedColor.withAlpha(0),
                    ProductColor.instance.seedColor.withAlpha(0),
                    ProductColor.instance.seedColor,
                  ],
                  stops: const [0.0, 0.28, 0.72, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightText(int weight, BuildContext context) {
    final isActive = selectedWeight == weight;
    final opacity = _calculateOpacity(weight);
    final fontSize = _calculateFontSize(weight);

    return Align(
      child: Text(
        context.localizeDigits('$weight'),
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: isActive ? FontWeight.normal : null,
          color: ProductColor.instance.white.withAlpha(opacity),
          fontSize: fontSize,
        ),
      ),
    );
  }

  int _calculateOpacity(int weight) {
    final difference = (weight - selectedWeight).abs();
    if (difference == 0) return 255;
    if (difference == 1) return 204;
    if (difference == 2) return 127;
    return 76;
  }

  double _calculateFontSize(int weight) {
    final difference = (weight - selectedWeight).abs();
    if (difference == 0) return 34;
    if (difference == 1) return 24;
    if (difference == 2) return 16;
    return 14;
  }
}
