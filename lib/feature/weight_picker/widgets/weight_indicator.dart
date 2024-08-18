part of '../weight_picker.dart';

class WeightIndicator extends StatelessWidget {
  final int selectedWeight;
  final PageController weightPickerController;
  const WeightIndicator({required this.weightPickerController, super.key, this.selectedWeight = 62});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: PageView.builder(
        controller: weightPickerController,
        itemCount: 300,
        itemBuilder: (context, index) {
          return _buildWeightText(index);
        },
      ),
    );
  }

  Widget _buildWeightText(int index) {
    final isActive = selectedWeight == index;
    final opacity = _calculateOpacity(index);
    final fontSize = _calculateFontSize(index);

    return Align(
      child: Text(
        '$index',
        style: TextStyle(
          fontWeight: isActive ? FontWeight.normal : null,
          color: Colors.white.withOpacity(opacity),
          fontSize: fontSize,
        ),
      ),
    );
  }

  double _calculateOpacity(int index) {
    final difference = (index - selectedWeight).abs();
    if (difference == 0) return 1;
    if (difference == 1) return 0.8;
    if (difference == 2) return 0.5;
    return 0.3;
  }

  double _calculateFontSize(int index) {
    final difference = (index - selectedWeight).abs();
    if (difference == 0) return 34;
    if (difference == 1) return 24;
    if (difference == 2) return 16;
    return 14;
  }
}
