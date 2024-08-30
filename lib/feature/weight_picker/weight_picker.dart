import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'weight_picker_model.dart';
part 'widgets/weight_picker.dart';
part 'widgets/weight_indicator.dart';
part 'widgets/indicator_clipper.dart';
part 'extension/value_extension.dart';

@RoutePage(name: 'WeightView')
@immutable
final class WeightPicker extends StatelessWidget {
  const WeightPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.weight_select_weight.tr(),
      ),
      body: const _WeightPickerBody(),
    );
  }
}

@immutable
final class _WeightPickerBody extends StatefulWidget {
  const _WeightPickerBody();

  @override
  State<_WeightPickerBody> createState() => __WeightPickerBodyState();
}

class __WeightPickerBodyState extends State<_WeightPickerBody> with DialogUtil, _WeightPickerModel {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: _IndicatorClipper(),
              child: ClipRRect(
                child: Container(
                  height: context.weightIndicatorHeight,
                  width: context.weightIndicatorWidth,
                  padding: ProductPadding.ten(),
                  decoration: BoxDecoration(
                    color: ProductColor().seedColor,
                    borderRadius: const ProductRadius.ten(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _WeightIndicator(
                        weightTextController: _weightTextController,
                        fieldFocus: _fieldFocus,
                        textFieldChange: _textFieldChange,
                      ),
                      _WeightPickerWidget(
                        weightPickerController: _weightController,
                        minVal: _minWeight,
                        selectedWeight: _selectedWeight,
                        maxVal: _maxWeight,
                        isDisabled: isFocused,
                      ),
                      _WeightPickerWidget(
                        weightPickerController: _decimalWeightController,
                        minVal: 0,
                        selectedWeight: _selectedDecimalWeight,
                        maxVal: _decimalMaxWeight,
                        isDisabled: isFocused,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
