import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:flutter/material.dart';

part 'weight_picker_model.dart';
part 'widgets/weight_indicator.dart';
part 'widgets/indicator_clipper.dart';

@RoutePage(name: 'WeightView')
final class WeightPicker extends StatelessWidget {
  const WeightPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        title: const Text('Select Weight'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _WeightPickerBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeightPickerBody extends StatefulWidget {
  const _WeightPickerBody();

  @override
  State<_WeightPickerBody> createState() => __WeightPickerBodyState();
}

class __WeightPickerBodyState extends State<_WeightPickerBody> with WeightPickerModel {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomPentagon(),
      child: ClipRRect(
        borderRadius: const ProductRadius.ten(),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: context.height * 0.6,
          width: context.width * 0.9,
          padding: const ProductPadding.ten(),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: ProductColor().seedColor,
            borderRadius: const ProductRadius.ten(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeightIndicator(),
              WeightIndicator(
                weightPickerController: _weightController,
                minVal: _minWeight,
                selectedWeight: _selectedWeight,
                maxVal: _maxWeight,
              ),
              WeightIndicator(
                weightPickerController: _decimalWeightController,
                minVal: _decimalMinWeight,
                selectedWeight: _selectedDecimalWeight,
                maxVal: _decimalMaxWeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightIndicator() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: ProductColor().white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _weightTextController,
            onTapOutside: (_) => context.unfocus,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall!.copyWith(
              color: ProductColor().seedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Kg',
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge!.copyWith(
              color: ProductColor().seedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
