import 'package:auto_route/auto_route.dart';
import 'package:bodymetrics/core/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'weight_picker_model.dart';
part 'widgets/weight_indicator.dart';
part 'widgets/indicator_clipper.dart';
part 'extension/value_extension.dart';

@RoutePage(name: 'WeightView')
final class WeightPicker extends StatelessWidget {
  const WeightPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScafflod(
      appBar: AppBar(
        title: Text(LocaleKeys.weight_select_weight.tr()),
      ),
      body: const _WeightPickerBody(),
    );
  }
}

class _WeightPickerBody extends StatefulWidget {
  const _WeightPickerBody();

  @override
  State<_WeightPickerBody> createState() => __WeightPickerBodyState();
}

class __WeightPickerBodyState extends State<_WeightPickerBody> with DialogUtil, WeightPickerModel {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
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
                        isDisabled: isFocused,
                      ),
                      WeightIndicator(
                        weightPickerController: _decimalWeightController,
                        minVal: _decimalMinWeight,
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

  Widget _buildWeightIndicator() {
    return CircleAvatar(
      radius: 55,
      backgroundColor: ProductColor().white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Focus(
            onFocusChange: _fieldFocus,
            child: TextField(
              controller: _weightTextController,
              keyboardType: TextInputType.number,
              onTapOutside: (_) => context.unfocus,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
              ],
              onChanged: _textFieldChange,
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
          ),
          Text(
            LocaleKeys.weight_kg.tr(),
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
