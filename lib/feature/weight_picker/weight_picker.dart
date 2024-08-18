import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';

import 'package:flutter/material.dart';

part 'weight_picker_model.dart';
part 'widgets/weight_indicator.dart';
part 'widgets/indicator_clipper.dart';

@RoutePage(name: 'WeightView')
final class WeightPicker extends StatefulWidget {
  const WeightPicker({super.key});

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        title: const Text('Select Weight'),
      ),
      body: const _WeightPickerBody(),
    );
  }
}

class _WeightPickerBody extends StatefulWidget {
  const _WeightPickerBody({super.key});

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
          height: context.height * 0.4,
          width: context.width * 0.9,
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: ProductColor().seedColor,
            borderRadius: const ProductRadius.ten(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              WeightIndicator(
                weightPickerController: _weightPickerController,
              ),
              _buildWeightIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightIndicator() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '65',
            textAlign: TextAlign.center,
            style: context.textTheme.displaySmall!.copyWith(
              color: ProductColor().seedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Kg',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium!.copyWith(
              color: ProductColor().seedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
